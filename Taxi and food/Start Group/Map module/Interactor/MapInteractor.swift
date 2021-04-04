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
import UIKit

class MapInteractor: MapInteractorProtocol {
    
    //MARK: - Properties
    
    internal weak var view: MapViewProtocol!
    
    private var locationManager: LocationManager
    
    //Addresses saved by user on server
    var addresses: [AddressResponseData] = []
    
    //User location
    var userLocation: CLLocationCoordinate2D? {
        didSet { self.getAddressFromLocation() }
    }
    
    //Address getted from user location
    internal var addressString: String? {
        didSet { self.view.setBottomViewAddressLabel(text: addressString) }
    }
    
    //Menu items
    var mapMenuData: [MapMenuSection] {
        return MapMenuData.getMapMenuSections()
    }
    
    //Map View controller state
    var mapViewControllerState: MapViewControllerStates {
        didSet { self.view.setViews(for: mapViewControllerState) }
    }
    
    //Destination address getted from map
    internal var destinationAddressFromMap: String? {
        didSet { self.view.setDestinationAddressText(for: destinationAddressFromMap)}
    }
    
    //Destination location getted from map
    internal var destinationLocationFromMap: CLLocationCoordinate2D? {
        didSet { self.view.setDestinationAnnotation(for: destinationLocationFromMap)}
    }
    
    //Source Address for order
    var sourceAddress: String?
    
    //Destination Address for order
    var destinationAddress: String?
    
    //Destination Address title for order
    var destinationAddressTitle: String?
    
    //Source address details
    var sourceAddressDetails: String?
    
    //Shops List
    var shopsList: [ShopResponseData] = [] {
        didSet {
            self.view.updateShopList(shopsList)
        }
    }
    
    //Shop detail
    var shopDetail: FoodCategoriesResponseData? {
        didSet {
            self.view.showFoodCategoriesForShop(shopDetail)
        }
    }

    
    var promos: [PromoShortData]?
    
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

    
     func getAllPromos() {

         let path = AllPromoServerPath.path.rawValue.getServerPath(for: 3)
         let resource = Resource<PromoResponse>(path: path, requestType: .GET)

        NetworkService.shared.makeRequest(for: resource, completion:  {[weak self] result in
             guard let self = self else { return }
             switch result {

             case .success(let promoResponse):
                self.promos = promoResponse.data
                self.view.updateData()
                 print(promoResponse.data)


             case .failure(let error):
                 print(error.localizedDescription)
             }
         })

     }
    
    public func isPromoAvailableByTime(timeFrom: String, timeTo: String) -> Bool {
            
            var bool = false
            let date = Date()
            let promoTime_fromSec = timeFrom.addNanoSec()
            let promoTime_toSec = timeTo.addNanoSec()
            
           
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ssZ"

            
            
            guard let promoTimeFrom = formatter.date(from: promoTime_fromSec) else { return false }
            guard let promoTimeTo = formatter.date(from: promoTime_toSec) else { return false }

            let calendar = Calendar.current
            let components1 = calendar.dateComponents([.hour, .minute, .second, .nanosecond], from: promoTimeTo)
            let components2 = calendar.dateComponents([.hour, .minute, .second, .nanosecond], from: promoTimeFrom)
            let components3 = calendar.dateComponents([.hour, .minute, .second, .nanosecond], from: date)

            
            guard let finalTimeFrom = calendar.date(from:components2) else { return false }
            guard let finalTimeTo = calendar.date(from:components1) else { return false }
            guard let finalTimeCurrent = calendar.date(from:components3) else { return false }


            if finalTimeFrom <= finalTimeCurrent && finalTimeTo >= finalTimeCurrent{

                bool = true
            }

            return bool
            
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

extension MapInteractor: AddressTranslatable { }

//MARK: - Get payments

extension MapInteractor {
    
    func getPaymentData() {
        
        guard let userData = PersistanceStoreManager.shared.getUserData(), let userId = userData.first?.id else { return }
        
        let resource = Resource<PaymentResponse>(path: PaymentRequestPaths.paymentCards.rawValue.getServerPath(for: Int(userId)), requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource, completion:  {[weak self] paymentResponse in
            guard let self = self else { return }
            
            switch paymentResponse {
            
            case .success(let paymentResponse):
                
                self.view.showPaymentsViewController(data: paymentResponse.data)
                
            case .failure(let error):
                
                print(error.localizedDescription)
            }
            
        })
    }
}

//MARK: - Get Tariffs

extension MapInteractor {
    
    func getTariffs() {
        
        guard let user = PersistanceStoreManager.shared.getUserData()?.first else { return }
        let path = TariffServerPath.path.rawValue.getServerPath(for: Int(user.id))
        
        let resource = Resource<TariffResponse>(path: path, requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource, completion:  {[weak self] result in
            guard let self = self else { return }
            switch result {
            
            case .success(let tariffResponse):
                self.view.showTariffPageViewController(tariffResponse.data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

//MARK: - Get addresses

extension MapInteractor {
    
    private func getAddresses() {
        
        guard let user = PersistanceStoreManager.shared.getUserData()?.first else { return }
        let path = AddressesRequestPaths.getAddresses.rawValue.getServerPath(for: Int(user.id))
        
        let resource = Resource<AddressResponse>(path: path, requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource, completion:  { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let addressResponse):
                self.addresses = addressResponse.data
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
}

//MARK: - ShowLocationInteractorDelegate

extension MapInteractor: ShowLocationInteractorDelegate {
    
    func get(location: CLLocationCoordinate2D?, and addressText: String) {
        self.destinationLocationFromMap = location
        self.destinationAddressFromMap = addressText
    }
}
 
//MARK: - Get shops list

extension MapInteractor {
    
    //Get shops list
    func getShopList() {
        
        guard let user = PersistanceStoreManager.shared.getUserData()?.first else { return }
        let path = ShopsRequestPaths.shopList.rawValue.getServerPath(for: Int(user.id))
        
        let resource = Resource<ShopsResponse>(path: path, requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            
            case .success(let response):
                self.shopsList = response.data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

// MARK: - Get Food Categories for shops

extension MapInteractor {
    
    func makeRequest(for shopId: Int) {
        
        guard let user = PersistanceStoreManager.shared.getUserData()?.first else { return }
        let path = FoodCategoriesNetworkPaths.shopDetails.rawValue.getServerPath(userId: Int(user.id), shopId: shopId)
        
        let resource = Resource<FoodCategoriesResponse>(path: path, requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource) { result in
            switch result {
            
            case .success(let response):
                self.shopDetail = response.data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

