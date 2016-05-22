//
//  ConfirmParentViewController.swift
//  SafeDrive
//
//  Created by Andrew Roach on 5/20/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

import UIKit

class ConfirmParentViewController: UIViewController, BacTrackAPIDelegate {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet var confirmParentView: UIView!
    @IBOutlet var connectToBACTrackView: UIView!
    @IBOutlet var takeReadingView: UIView!
    
    @IBOutlet var warmUpView: UIView!
    @IBOutlet weak var warmUpStatusLabel: UILabel!
    @IBOutlet weak var warmUpCircleView: CircleView!
    
    var mBacTrack: BacTrackAPI?
    
    let kDL = KinveyDownloader()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ConfirmParentViewController.reloadData), name: SETTINGSDOWNLOADEDNOTIFICATION, object: nil)
        mBacTrack = BacTrackAPI(delegate: self, andAPIKey: "0a32f2ab7bf144e4905e723347989b")

    }

    override func viewWillAppear(animated: Bool) {
        kDL.fetchSettingForChild(KCSUser.activeUser().username)
    }
    
    func reloadData() {
        let setting = kDL.downloadedSettings![0]
        if setting.cofirmedLink == NSNumber(bool: true) {
            connectToBACTrackView.frame = mainView.frame
            view.addSubview(connectToBACTrackView)
        }
        else {
            confirmParentView.frame = mainView.frame
            view.addSubview(confirmParentView)
            statusLabel.text = "Confirm \(setting.parentUserName!) as your parent"
        }
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
    
    @IBAction func connectToBACTrack(sender: UIButton) {
        mBacTrack?.connectToNearestBreathalyzer()
    }
    
    @IBAction func takeReadingButtonPressed(sender: UIButton) {
        
        print("takeReading Frame was: \(takeReadingView.frame)")
        warmUpView.frame = takeReadingView.frame
        takeReadingView.removeFromSuperview()
        view.addSubview(warmUpView)
        warmUpStatusLabel.text = "Warming Up..."
        
        mBacTrack?.startCountdown()
    
    }
    
    /////////BACTrack Delegate Methods///////////////
    
    func BacTrackAPIKeyDeclined(errorMessage: String!) {
        print("There is an error with message from BAC track \(errorMessage)")
    }
    
    func BacTrackConnected() {
        takeReadingView.frame = connectToBACTrackView.frame
        connectToBACTrackView.removeFromSuperview()
        view.addSubview(takeReadingView)
    }
    
    func BacTrackCountdown(seconds: NSNumber!, executionFailure error: Bool) {
        
    }
    
    func BacTrackStart() {
        
    }
    
    func BacTrackBlow() {
        
    }
    
    func BacTrackAnalyzing() {
        
    }
    
    func BacTrackResults(bac: CGFloat) {
        
    }
    
    
    
    
    
    
    
}
