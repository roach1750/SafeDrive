//
//  TestDetailsViewController.swift
//  SafeDrive
//
//  Created by Andrew Roach on 6/1/16.
//  Copyright © 2016 Andrew Roach. All rights reserved.
//

import UIKit
import MapKit
class TestDetailsViewController: UIViewController {

    var currentTest: Test?
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var bacResultLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMapView()
        setLabels()
    }
    
    func setLabels(){
        locationLabel.text = "Location needs to be geocoded"
        bacResultLabel.text = "BAC Result: \(currentTest!.bacResult!)"
    }
    

    func setUpMapView(){
        let coord = currentTest?.location?.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coord!, span: span)
        mapView.setRegion(region, animated: true)
    
        let annoation = MKPointAnnotation()
        annoation.coordinate = coord!
        mapView.addAnnotation(annoation)
        
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
