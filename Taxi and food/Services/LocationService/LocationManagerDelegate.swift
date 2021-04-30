//
//  LocationManagerDelegate.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 16.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    
    func cantUpdateLocation(_ reason: LocationAuthStatus)
    func getLocation(_ location: CLLocationCoordinate2D)
    
}
