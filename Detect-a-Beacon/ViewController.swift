//
//  ViewController.swift
//  Detect-a-Beacon
//
//  Created by Yohannes Wijaya on 10/3/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Stored Properties
    
    var locationManager: CLLocationManager!
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var distanceReadingLabel: UILabel!
    
    // MARK: - Delegate Methods
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        guard status == .AuthorizedWhenInUse else { return }
        guard CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self) else { return }
        guard CLLocationManager.isRangingAvailable() else { return }
        // do stuff
    }
    
    // MARK: - Methods Override

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
        self.view.backgroundColor = UIColor.grayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

