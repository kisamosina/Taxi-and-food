//
//  ShowLocationInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import MapKit

class ShowLocationInteractor: ShowLocationInteractorProtocol {
    
    internal weak var view: ShowLocationViewProtocol!
    
    private var locationManager: LocationManager
    
    internal var addressEnterDetailViewType: AddressEnterDetailViewType
    
    var userLocation: CLLocationCoordinate2D? {
        
        didSet {
            self.getAddressFromLocation()
        }
    }
    
    var addressString: String? {
        didSet {
            self.view.setupAddressEnterDetailLocationLabelText(addressString)
        }
    }
    
    
    required init(view: ShowLocationViewProtocol, userLocation: CLLocationCoordinate2D?, addressEnterDetailViewType: AddressEnterDetailViewType) {
        self.view = view
        self.userLocation = userLocation
        self.locationManager = LocationManager.shared
        self.addressEnterDetailViewType = addressEnterDetailViewType
        self.locationManager.delegate = self
        self.getAddressFromLocation()
    }
    
    func getLocationRegion() -> MKCoordinateRegion? {
        guard let userLocation = userLocation else { return nil }
        let regionRadius = MapViewControllerMapData.regionRadius.rawValue
        return MKCoordinateRegion(center: userLocation,
                                  latitudinalMeters: regionRadius,
                                  longitudinalMeters: regionRadius)}
}

//MARK: - AddressTranslatable
extension ShowLocationInteractor: AddressTranslatable { }

//MARK: - LocationManagerDelegate
extension ShowLocationInteractor: LocationManagerDelegate {
    
    func cantUpdateLocation(_ reason: LocationAuthStatus) { }
    
    func getLocation(_ location: CLLocationCoordinate2D) {
        self.userLocation = location
        self.view.showMapRegion(region: self.getLocationRegion())
    }
}
