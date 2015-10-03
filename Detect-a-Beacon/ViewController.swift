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
        self.startScanning()
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        guard beacons.count > 0 else {
            self.updateDistance(.Unknown)
            return
        }
        let beacon = beacons[0]
        self.updateDistance(beacon.proximity)
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

    // MARK: - Local Methods
    
    func startScanning() {
        let uuid = NSUUID(UUIDString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "myBeacon")
        
        self.locationManager.startMonitoringForRegion(beaconRegion)
        self.locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    func updateDistance(distance: CLProximity) {
        UIView.animateWithDuration(0.8) { [unowned self] () -> Void in
            switch distance {
            case .Unknown:
                self.view.backgroundColor = UIColor.grayColor()
                self.distanceReadingLabel.text = "UNKNOWN"
                
            case .Far:
                self.view.backgroundColor = UIColor.greenColor()
                self.distanceReadingLabel.text = "FAR"
                
            case .Near:
                self.view.backgroundColor = UIColor.orangeColor()
                self.distanceReadingLabel.text = "NEAR"
                
            case .Immediate:
                self.view.backgroundColor = UIColor.redColor()
                self.distanceReadingLabel.text = "RIGHT HERE"
            }
        }
    }
}

