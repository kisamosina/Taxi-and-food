//
//  MapInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class MapInteractor: MapInteractorProtocol {
    
    //MARK: - Properties
    
    internal weak var view: MapViewProtocol!
    
    private var locationManager: LocationManager
    
    var addresses: [AddressResponseData] = []
    
    var userLocation: CLLocationCoordinate2D? {
        didSet {
            self.getAddressFromLocation()
        }
    }
    
    var addressString: String? {
        didSet {
            self.view.setBottomViewAddressLabel(text: addressString)
        }
    }
    
    var mapMenuData: [MapMenuSection] {
        return MapMenuData.getMapMenuSections()
    }
    
    var mapViewControllerState: MapViewControllerStates {
        didSet {
            self.view.setViews(for: mapViewControllerState)
        }
    }
    
    //MARK: - Initializer
    
    required init(view: MapViewProtocol) {
        self.view = view
        self.mapViewControllerState = .start
        self.locationManager = LocationManager.shared
        self.locationManager.delegate = self
        self.getAddresses()
    }

    //MARK: - MapInteractorProtocol Methods
    
    //Set Map View controller states
    
    func setViewControllerState(_ state: MapViewControllerStates) {
        self.mapViewControllerState = state
    }
    
    //GET REGION FOR USER LOCATION
    
    func getUserLoctaionRegion() -> MKCoordinateRegion? {
        guard let userLocation = self.userLocation else { return nil }
        return self.makeRegion(regionRadius: MapViewControllerMapData.regionRadius.rawValue, for: userLocation)
    }

    
}

//MARK: - Location manager delegate

extension MapInteractor: LocationManagerDelegate {
    
    func cantUpdateLocation(_ reason: LocationAuthStatus) {
        self.view.showLocationSettingsAlert(title: AlertControllerTexts.attentionText, message: reason.status)
    }
    
    func getLocation(_ location: CLLocationCoordinate2D) {
        self.userLocation = location
        let region = self.makeRegion(regionRadius: MapViewControllerMapData.regionRadius.rawValue, for: location)
        self.view.showUserLocation(region: region)
    }
    
}

//MARK: - Work with locations on map

extension MapInteractor {
    
    //Make region
    private func makeRegion(regionRadius: CLLocationDistance, for location: CLLocationCoordinate2D) -> MKCoordinateRegion {
        return MKCoordinateRegion(center: location,
                                  latitudinalMeters: regionRadius,
                                  longitudinalMeters: regionRadius)
    }
}

//MARK: - Creating address from location

extension MapInteractor {
    
    func getAddressFromLocation() {
        
        guard let userlocation = userLocation else { return }
        
        let location = CLLocation(latitude: userlocation.latitude, longitude: userlocation.longitude)
        
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location) {[weak self] (pm, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let placemark = pm?.first, let self = self else { return }
            
            self.addressString =  "\(placemark.thoroughfare ?? "..."), \(placemark.subThoroughfare ?? "")"
        }
        
    }
}

//MARK: - Get payments

extension MapInteractor {
    
    func getPaymentData() {
        
        guard let userData = PersistanceStoreManager.shared.getUserData(), let userId = userData.first?.id else { return }
        
        let resource = Resource<PaymentResponse>(path: PaymentRequestPaths.paymentCards.rawValue.getServerPath(for: Int(userId)), requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource) {[weak self] paymentResponse in
            guard let self = self else { return }
            
            switch paymentResponse {
            
            case .success(let paymentResponse):
                
                self.view.showPaymentsViewController(data: paymentResponse.data)
                
            case .failure(let error):
                
                print(error.localizedDescription)
            }
            
        }
    }
}

//MARK: - Get Tariffs

extension MapInteractor {
    
    func getTariffs() {
        
        guard let user = PersistanceStoreManager.shared.getUserData()?[0] else { return }
        let path = TariffServerPath.path.rawValue.getServerPath(for: Int(user.id))
        
        let resource = Resource<TariffResponse>(path: path, requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource) {[weak self] result in
            guard let self = self else { return }
            switch result {
            
            case .success(let tariffResponse):
                self.view.showTariffPageViewController(tariffResponse.data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - Get addresses

extension MapInteractor {
    
    private func getAddresses() {
        
        guard let user = PersistanceStoreManager.shared.getUserData()?[0] else { return }
        let path = AddressesRequestPaths.getAddresses.rawValue.getServerPath(for: Int(user.id))
        
        let resource = Resource<AddressResponse>(path: path, requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let addressResponse):
                self.addresses = addressResponse.data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

