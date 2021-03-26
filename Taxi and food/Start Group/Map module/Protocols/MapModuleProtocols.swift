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

//MARK: - MapInteractorProtocol

protocol MapInteractorProtocol: class {
    
    var view: MapViewProtocol! { get }
    
    //Menu items
    var mapMenuData: [MapMenuSection] { get }

    //User location
    var userLocation: CLLocationCoordinate2D? { get set }
    
    //Address getted from user location
    var addressString: String? { get set }

    //Map View controller state
    var mapViewControllerState: MapViewControllerStates { get set }
    
    //Addresses saved by user on server
    var addresses: [AddressResponseData] { get set }
    
    //Destination address getted from map
    var destinationAddressFromMap: String? { get set }
    
    //Destination location getted from map
    var destinationLocationFromMap: CLLocationCoordinate2D? { get set }
    
    //Source Address for order
    var sourceAddress: String? { get set }
    
    //Destination Address for order
    var destinationAddress: String? { get set }
    
    //Source address details
    var sourceAddressDetails: String? { get set }

    init(view: MapViewProtocol)
    
    //Set VC state
    func setViewControllerState(_ state: MapViewControllerStates)
    
    //Get tariffs from server
    func getTariffs()
    
    //Get map region
    func getUserLoctaionRegion() -> MKCoordinateRegion?
    
    //Get paymentOptions from server
    func getPaymentData()
}

//MARK: - MapViewProtocol

protocol MapViewProtocol: class {
    
    var interactor: MapInteractorProtocol! { get set }
    
    func showTariffPageViewController(_ tariffs: [TariffData])
    
    func showUserLocation(region: MKCoordinateRegion)
    
    func showLocationSettingsAlert(title: String, message: String)
    
    func setViews(for state: MapViewControllerStates)
    
    func setBottomViewAddressLabel(text: String?)
    
    func showPaymentsViewController(data: [PaymentCardResponseData])
    
    func setDestinationAnnotation(for coordinate: CLLocationCoordinate2D?)
    
    func setDestinationAddressText(for addressText: String?)
}