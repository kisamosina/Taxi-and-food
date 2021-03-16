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

protocol MapInteractorProtocol: class {
    var view: MapViewProtocol! { get }
    var mapMenuData: [MapMenuSection] { get }
    var userLocation: CLLocationCoordinate2D? { get set }
    
    init(view: MapViewProtocol)
    
    func getTariffs()
    func getUserLoctaionRegion() -> MKCoordinateRegion?
}

class MapInteractor: MapInteractorProtocol {
    
    //MARK: - Properties
    
    internal weak var view: MapViewProtocol!
    private var locationManager: LocationManager
    var userLocation: CLLocationCoordinate2D?
    
    var mapMenuData: [MapMenuSection] {
        return MapMenuData.getMapMenuSections()
    }
    
    //MARK: - Initializer
    
    required init(view: MapViewProtocol) {
        self.view = view
        self.locationManager = LocationManager.shared
        self.locationManager.delegate = self
    }

    //MARK: - MapInteractorProtocol Methods
    
    //GET TARIFFS FROM SERVER
    
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
