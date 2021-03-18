//
//  LocationManager.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 16.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    static var shared = LocationManager()
    
    private let cllocationManager = CLLocationManager()
    
    weak var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        cllocationManager.delegate = self
        cllocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        cllocationManager.requestWhenInUseAuthorization()
        cllocationManager.startUpdatingLocation()
    }

}

//MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        
        case .notDetermined:
            break
        case .restricted:
            self.cllocationManager.stopUpdatingLocation()
            self.delegate?.cantUpdateLocation(.denied)
        case .denied:
            self.cllocationManager.stopUpdatingLocation()
            self.delegate?.cantUpdateLocation(.denied)
        default:
            self.cllocationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else { return }
        self.delegate?.getLocation(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error.localizedDescription)
        manager.stopUpdatingLocation()
    }
}
