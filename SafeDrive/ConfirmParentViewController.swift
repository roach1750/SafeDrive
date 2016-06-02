//
//  ConfirmParentViewController.swift
//  SafeDrive
//
//  Created by Andrew Roach on 5/20/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

import UIKit

class ConfirmParentViewController: UIViewController, BacTrackAPIDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet var confirmParentView: UIView!
    @IBOutlet var connectToBACTrackView: UIView!
    @IBOutlet var takeReadingView: UIView!
    
    @IBOutlet var warmUpView: UIView!
    @IBOutlet weak var warmUpStatusLabel: UILabel!
    
    @IBOutlet var startBlowingView: UIView!
    
    @IBOutlet var blowInProgressView: UIView!
    
    @IBOutlet var analyzingView: UIView!
    
    @IBOutlet var testCompleteView: UIView!
    @IBOutlet weak var testCompleteStatusLabel: UILabel!
    
    
    var mBacTrack: BacTrackAPI?
    
    let kDL = KinveyDownloader()
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ConfirmParentViewController.reloadData), name: SETTINGSDOWNLOADEDNOTIFICATION, object: nil)
        mBacTrack = BacTrackAPI(delegate: self, andAPIKey: "0a32f2ab7bf144e4905e723347989b")
        setUpLocationServices()

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
        warmUpView.frame = takeReadingView.frame
        takeReadingView.removeFromSuperview()
        view.addSubview(warmUpView)
        warmUpStatusLabel.text = "Warming Up..."
        print("Take Reading Button Pressed")
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
    
    var firstTimeOnCountDown = true
    func BacTrackCountdown(seconds: NSNumber!, executionFailure error: Bool) {
        if firstTimeOnCountDown == true {
            drawCircleWithDuration(seconds.doubleValue, andColor: UIColor.redColor(), andView: warmUpView)
            firstTimeOnCountDown = false
        }
        
    }
    
    func BacTrackStart() {
        firstTimeOnCountDown = true
        startBlowingView.frame = warmUpView.frame
        warmUpView.removeFromSuperview()
        view.addSubview(startBlowingView)
    }
    
    func BacTrackBlow() {
        blowInProgressView.frame = startBlowingView.frame
        startBlowingView.removeFromSuperview()
        view.addSubview(blowInProgressView)

    }
    
    func BacTrackAnalyzing() {
        analyzingView.frame = blowInProgressView.frame
        blowInProgressView.removeFromSuperview()
        view.addSubview(analyzingView)
    }
    
    func BacTrackResults(bac: CGFloat) {
        testCompleteView.frame = analyzingView.frame
        analyzingView.removeFromSuperview()
        view.addSubview(testCompleteView)
        testCompleteStatusLabel.text = String(bac)
        //Why is this called twice?
        uploadTestToParent(bac)
        print("uploading test result")
    }
    
    
    ////////Test Complete
    
    func uploadTestToParent(bac:CGFloat){
        let testToUpload = Test()
        testToUpload.bacResult = NSNumber(double: Double(bac))
        testToUpload.location = currentLocation
        if bac == 0 {
            testToUpload.pass = NSNumber(bool: true)
        }
        else {
            testToUpload.pass = NSNumber(bool: false)
        }
        testToUpload.childUserName = KCSUser.activeUser().username
        testToUpload.childFirstName = KCSUser.activeUser().givenName
        testToUpload.childLastName = KCSUser.activeUser().surname
        let setting = kDL.downloadedSettings![0]
        testToUpload.parentUserName = setting.parentUserName
        
        let kUP = KinveyUploader()
        kUP.uploadTest(testToUpload)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /////////Location Methods////////////////////////
    func setUpLocationServices(){
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.requestLocation()
        }
        else {
            locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        locationManager?.requestLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Found Location!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print(locations[0])
        currentLocation = locations[0]
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("ERROR: \(error)")
    }
    
    
    
    var circleAnimationLayer = CAShapeLayer()
    
    func drawCircleWithDuration(duration: Double, andColor color: UIColor, andView viewToAddTo: UIView) {
        // Set up the shape of the circle
        
        circleAnimationLayer.removeFromSuperlayer()
        let testingFrame: CGRect = takeReadingView.frame
        let radius: CGFloat = testingFrame.size.width * 0.4
        
        circleAnimationLayer = CAShapeLayer()
        // Make a circular shape
        circleAnimationLayer.path = UIBezierPath(roundedRect: CGRectMake(0, 0, 2.0 * radius, 2.0 * radius), cornerRadius: radius).CGPath
        // Center the shape in self.view
        circleAnimationLayer.position = CGPointMake(CGRectGetMidX(testingFrame) - radius, CGRectGetMidY(testingFrame) - radius)
        // Configure the apperence of the circle
        circleAnimationLayer.fillColor = UIColor.clearColor().CGColor
        circleAnimationLayer.strokeColor = color.CGColor
        circleAnimationLayer.lineWidth = 15
        // Add to parent layer
        viewToAddTo.layer.addSublayer(circleAnimationLayer)
        
        let drawAnimation = CABasicAnimation(keyPath: "strokeStart")
        drawAnimation.duration = duration
        drawAnimation.repeatCount = 1.0
        drawAnimation.fromValue = 0.0
        drawAnimation.toValue = 1.0
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        circleAnimationLayer.addAnimation(drawAnimation, forKey: "drawCircleAnimation")
        
    }
    
    
    
    
    
}
