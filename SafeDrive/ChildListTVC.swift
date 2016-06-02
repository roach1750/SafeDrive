//
//  ChildListTVC.swift
//  SafeDrive
//
//  Created by Andrew Roach on 5/20/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

import UIKit

class ChildListTVC: UITableViewController {

    var data: [Setting]?
    let kVD = KinveyDownloader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kVD.fetchSettingsAsParent()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ChildListTVC.reloadData), name: SETTINGSDOWNLOADEDNOTIFICATION, object: nil)
    }
    
    func reloadData(){
        data = kVD.downloadedSettings
        tableView.reloadData()
    }
    
    @IBAction func refresh(sender: UIBarButtonItem) {
        kVD.fetchSettingsAsParent()
    }
    

    @IBAction func addChildButtonPressed(sender: UIBarButtonItem) {
        var childEmailTextField: UITextField?
        let alertController = UIAlertController(title: "Please enter your child's email address.", message: nil, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "Add", style: .Default, handler: { (action) -> Void in
            if childEmailTextField?.text?.characters.count > 0 {
                print(childEmailTextField?.text!)
                let kUP = KinveyUploader()
                kUP.createAndUploadSettingForChildEmailAdress((childEmailTextField?.text)!)
            }
        
        })
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
        }
        alertController.addAction(ok)
        alertController.addAction(cancel)
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            // Enter the textfiled customization code here.
            childEmailTextField = textField
            childEmailTextField?.placeholder = "Child's Email"
        }
        alertController.view.setNeedsLayout()
        presentViewController(alertController, animated: true, completion: nil)
        
    
    }
    
    
    
    
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let allData = data {
            return allData.count
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("childCell", forIndexPath: indexPath)
        
        let currentSetting = data![indexPath.row]
        
        
        if currentSetting.cofirmedLink == NSNumber(bool: false) {
            cell.detailTextLabel?.text = "unconfirmed"
            cell.textLabel?.text = currentSetting.childUserName!
        }
        else {
            let nameString = currentSetting.childFirstName! + " " + currentSetting.childLastName!
            cell.textLabel?.text = nameString

            cell.detailTextLabel?.text = "confirmed"
        }
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        performSegueWithIdentifier("showTest", sender: indexPath)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTest" {
            let dv = segue.destinationViewController as! TestHistoryTVC
            dv.setting = data![(sender?.row)!]
        }
    }
    
    
    

    
}
