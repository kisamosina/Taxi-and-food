//
//  Protocols.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 19.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol MapInteractorProtocol: class {
    var view: MapViewProtocol! { get }
    var mapMenuData: [MapMenuSection] { get }
    var userLocation: CLLocationCoordinate2D? { get set }
    var addressString: String? { get set }
    var mapViewControllerState: MapViewControllerStates { get set }

    init(view: MapViewProtocol)
    
    func setViewControllerState(_ state: MapViewControllerStates)
    func getTariffs()
    func getUserLoctaionRegion() -> MKCoordinateRegion?
}

protocol MapViewProtocol: class {
    var interactor: MapInteractorProtocol! { get set }
    func showTariffPageViewController(_ tariffs: [TariffData])
    func showUserLocation(region: MKCoordinateRegion)
    func showLocationSettingsAlert(title: String, message: String)
    func setViews(for state: MapViewControllerStates)
    func setBottomViewAddressLabel(text: String?)
}
