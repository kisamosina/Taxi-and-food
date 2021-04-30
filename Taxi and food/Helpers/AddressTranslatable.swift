//
//  AddressTranslatable.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import CoreLocation

protocol AddressTranslatable: AnyObject {
    var userLocation: CLLocationCoordinate2D? { get set }
    var addressString: String? { get set}
    func getAddressFromLocation()
    func getAddress(from location: CLLocationCoordinate2D, addressResult: @escaping (String) -> Void)
}

extension AddressTranslatable {
    
    func getAddressFromLocation() {
        
        guard let userlocation = userLocation else { return }
        
        self.getAddress(from: userlocation) { [weak self] addressText in
            self?.addressString = addressText
        }
        
    }
    
    func getAddress(from location: CLLocationCoordinate2D, addressResult: @escaping (String) -> Void) {
        
        let location = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        let geoCoder = CLGeocoder()
        
        let locale = Locale(identifier: UserDefaults.standard.getAppLanguage().getLocaleID())
        
        geoCoder.reverseGeocodeLocation(location, preferredLocale: locale ) {(pm, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let placemark = pm?.first else { return }
            
            let addressString =  "\(placemark.thoroughfare ?? "..."), \(placemark.subThoroughfare ?? "")"
            
            addressResult(addressString)
        }
    }
}
