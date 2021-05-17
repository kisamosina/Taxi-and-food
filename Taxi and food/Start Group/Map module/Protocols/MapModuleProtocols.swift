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

protocol MapInteractorProtocol: AnyObject {
    
    var view: MapViewProtocol! { get }
    
    //Menu items
    var mapMenuData: [MapMenuSection] { get }

    //User location
    var userLocation: CLLocationCoordinate2D? { get set }
    
    var promos: [PromoShortData]? { get }
    
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
    
    //Destination Address title for order
    var destinationAddressTitle: String? { get set }
    
    //Source address details
    var sourceAddressDetails: String? { get set }
    
    //Shops list
    var shopsList:[ShopResponseData] { get set }
    
    //Estimated trip time
    var estimatedTripTime: String { get }
    
    //Sum order
    var sumOrder: Double { get set }
    
    //Entered points
    var enteredPoints: Int? { get set }
    
    //Promocode discount
    var promocodeDiscount: Double { get set }
    
    //Final sumOrder
    var finalSumOrder: Double { get }
    
    init(view: MapViewProtocol)
    
    //Set VC state
    func setViewControllerState(_ state: MapViewControllerStates)
    
    //Get tariffs from server
    func getTariffs()
    
    //Get map region
    func getUserLoctaionRegion() -> MKCoordinateRegion?
    
    //Get paymentOptions from server
    func getPaymentData()
    
    func getAllPromos()
    
    func isPromoAvailableByTime(timeFrom: String, timeTo: String) -> Bool
    
    // Get List of shops
    func getShopList()
    
    //Get Food Categories for shops
    func makeRequest(for shopId: Int)
    
    // Make Polyline render
    func makePolylineRended(from overlay: MKOverlay) -> MKOverlayRenderer
    
    //Building route
    func buildARoute()
    
    //Get points
    func getPoints()
    
    //Set sum order
    func setSumOrder(_ value: Double)
    
    //Save wasted Points
    func saveWastedPoints(_ points: Int)
    
    //Set promocode Discount
    func setPromocodeDiscount(discount: Int)
}


//MARK: - MapViewProtocol

protocol MapViewProtocol: AnyObject {
    
    var interactor: MapInteractorProtocol! { get set }
    
    func showTariffPageViewController(_ tariffs: [TariffData])
    
    func showUserLocation(region: MKCoordinateRegion)
    
    func showLocationSettingsAlert(title: String, message: String)
    
    func setViews(for state: MapViewControllerStates)
    
    func setBottomViewAddressLabel(text: String?)
    
    func showPaymentsViewController(data: [PaymentCardResponseData])
    
    func setDestinationAnnotation(for coordinate: CLLocationCoordinate2D?)
    
    func setDestinationAddressText(for addressText: String?)
    
    func updateData()

    func updateShopList(_ list: [ShopResponseData])
    
    func showFoodCategoriesForShop(_ shopDetailData: FoodCategoriesResponseData? )
    
    func draw(route: MKRoute)
    
    func showPoints(_ credit: Int)
    
    func activatePoints(_ pointsText: String)
    
    func activatePromocodeDiscount(_ discount: String)
    
}
