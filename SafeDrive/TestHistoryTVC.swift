//
//  TestHistoryTVC.swift
//  SafeDrive
//
//  Created by Andrew Roach on 6/1/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

import UIKit

class TestHistoryTVC: UITableViewController {

    var setting: Setting? {
        didSet{
            kDL = KinveyDownloader()
            if let childUN = setting?.childUserName {
                kDL?.fetchAllTestForChildWithUserName(childUN)
                self.title = (setting?.childFirstName)! + " " + (setting?.childLastName)!
            }
        }
    }
    
    var kDL: KinveyDownloader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TestHistoryTVC.reloadTable), name: TESTSDOWNLOADEDNOTIFICATION, object: nil)
    }

    func reloadTable() {
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (kDL?.downloadedTest) != nil {
            return (kDL?.downloadedTest?.count)!
        }
        else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("test", forIndexPath: indexPath)
        let currentTest = kDL?.downloadedTest![indexPath.row]
        cell.textLabel?.text = dateToString((currentTest?.metadata?.creationTime())!)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showTestDetails", sender: indexPath)
    }
    
    func dateToString(date:NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY HH:mm:ss"
        return dateFormatter.stringFromDate(date)
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTestDetails" {
            let dV = segue.destinationViewController as! TestDetailsViewController
            dV.currentTest = kDL?.downloadedTest![sender!.row]
        }
    }

}
