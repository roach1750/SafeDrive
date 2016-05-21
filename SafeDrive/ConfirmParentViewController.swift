//
//  ConfirmParentViewController.swift
//  SafeDrive
//
//  Created by Andrew Roach on 5/20/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

import UIKit

class ConfirmParentViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ConfirmParentViewController.reloadData), name: SETTINGSDOWNLOADEDNOTIFICATION, object: nil)
    }
    
    let kDL = KinveyDownloader()

    override func viewWillAppear(animated: Bool) {
        kDL.fetchSettingForChild(KCSUser.activeUser().username)
    }
    
    func reloadData() {
        let setting = kDL.downloadedSettings![0]
        statusLabel.text = "Confirm \(setting.parentUserName!) as your parent"
    }
    
    @IBAction func confirmButtonPressed(sender: UIButton) {
        let setting = kDL.downloadedSettings![0]
        setting.cofirmedLink = NSNumber(bool: true)
        setting.childFirstName = KCSUser.activeUser().givenName
        setting.childLastName = KCSUser.activeUser().surname
        print(KCSUser.activeUser().getValueForAttribute(KCSUserAttributeSurname) as? String)
        let kUP = KinveyUploader()
        kUP.uploadSetting(setting)
    }
}
