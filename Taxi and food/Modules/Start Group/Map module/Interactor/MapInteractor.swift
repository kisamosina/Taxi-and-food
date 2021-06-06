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
    
    private let pointsNetworkService: PointsNetworkServiceProtocol
    
    private let paymentWayNetworkService: PaymentWayNetworkServiceProtocol
    
    private let taxiorderNetworkService: TaxiOrderNetworkServiceProtocol
    
    private var timer: Timer?
    
    private var isTaxiFound = false
    
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
    
    var promos: [PromoShortData]?
    
    var estimatedTripTime: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return "≈15 мин"
        case .eng:
            return "≈15 min"
        }
    }
    
    //Sum order
    var sumOrder: Double = 0
    
    //Entered points
    var enteredPoints: Int? {
        didSet {
            if let enteredPoints = enteredPoints {
                view.activatePoints("- \(enteredPoints)")
            }
        }
    }
    
    //Promocode discount
    var promocodeDiscount: Double = 0 {
        didSet {
            if promocodeDiscount < 1 && promocodeDiscount != 0 {
                let discount = Int((promocodeDiscount * 100).rounded())
                view.activatePromocodeDiscount("- \(discount)%")
            }
        }
    }
    
    //Final sumOrder
    var finalSumOrder: Double {
        let finalSumOrder = (sumOrder - (sumOrder * promocodeDiscount)) - Double(enteredPoints ?? 0)
        guard finalSumOrder > 0 else { return 0 }
        return finalSumOrder
    }
    
    //Taxi prices
    var taxiPricesData: [TaxiPriceResponseModel] = [] {
        didSet {
            selectedTariff = taxiPricesData.first?.tariff.id
        }
    }
    
    //Selected tariff
    var selectedTariff: Int?
   
    //Entered promocodes
    var enteredPromocodes: [String] = []
    
    //Payment card id
    var paymentCardId: Int?
    
    //Payment way
    var paymentWay: String
    
    //Payment data
    var paymentsData: [PaymentCardResponseData] = []
    
    var taxiNotFoundCount: Int = 0
    
    //Tariffs data
    var tariffsData: [TariffData] = []
    
    //Taxi order response data
    var taxiOrderResponseData: TaxiPlaceOrderResponseModel? {
        didSet {
            if let taxiOrderResponseData = taxiOrderResponseData {
                view.taxiHasFound(taxiOrderResponseData)
            }
        }
    }

    //MARK: - Initializer
    
    required init(view: MapViewProtocol) {
        self.view = view
        self.mapViewControllerState = .start
        self.locationManager = LocationManager.shared
        self.paymentWay = PaymentWay.cash.rawValue
        self.pointsNetworkService = PointsNetworkService.shared
        self.paymentWayNetworkService = PaymentWayNetworkService.shared
        self.taxiorderNetworkService = TaxiOrderNetworkService.shared
        self.locationManager.delegate = self
        self.getAddresses()
        self.getAllPromos()
        self.getTariffs()
        self.getPaymentData()
    }

    //MARK: - Methods
    
    private func startTimer(timeInterval: TimeInterval, block: @escaping (Timer) -> ()) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: block)
    }
    
    func stopTimer() {
        timer?.invalidate()
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
    
    private enum PaymentWay: String {
        case cash, card
    }
    
    func getPaymentData() {
            
        paymentWayNetworkService.getPaymentWayData {[weak self] result in
            guard let self = self else { return }
            switch result {
            
            case .success(let paymentsData):
                self.paymentsData = paymentsData
                self.setSelectedPaymentWay()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setSelectedPaymentWay() {
        guard let savedPaymentWayTitle = PersistanceStoreManager.shared.getSavedPaymentWay()?.first?.title,
              let paymentCard = paymentsData.first(where: { PaymentWayTexts.cardTitle + $0.hidedNumber == savedPaymentWayTitle })
        else { return }
        paymentCardId = paymentCard.id
        paymentWay = PaymentWay.card.rawValue
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
                self.tariffsData = tariffResponse.data
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
                self.view.showFoodCategoriesForShop(response.data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Building a route for map

extension MapInteractor {
    
    func makePolylineRended(from overlay: MKOverlay) -> MKOverlayRenderer {
        
        guard let polyline = overlay as? MKPolyline else { return MKPolylineRenderer() }
//                let gradientColors = [Colors.buttonBlue.getColor(), Colors.taxiOrange.getColor()]
        let polylineRenderer = MKPolylineRenderer(overlay: polyline)
        polylineRenderer.fillColor = Colors.buttonBlue.getColor().withAlphaComponent(0.2)
        polylineRenderer.strokeColor = Colors.taxiOrange.getColor().withAlphaComponent(0.7)
        polylineRenderer.lineWidth = 3
        
        return polylineRenderer
    }
    
    func buildARoute() {
            
           guard let sourceCoordLocation = self.userLocation, let destinationCoordLocation = self.destinationLocationFromMap else { return }
            
            let sourcePlacemark = MKPlacemark(coordinate: sourceCoordLocation, addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: destinationCoordLocation, addressDictionary: nil)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
          
            
            let sourceAnnotation = MKPointAnnotation()
            sourceAnnotation.coordinate = sourceCoordLocation
            
            
            let destinationAnnotation = MKPointAnnotation()
            destinationAnnotation.coordinate = destinationCoordLocation
            
            let directionRequest = MKDirections.Request()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .automobile
            
            // Calculate the direction
            let directions = MKDirections(request: directionRequest)
            
            directions.calculate {
                (response, error) -> Void in
                
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                    }
                    
                    return
                }
            
                let route = response.routes[0]
                self.view.draw(route: route)
            }
        }
}

//MARK: - Get Taxi price

extension MapInteractor {
    
    
    func getPrice() {
        guard let from = sourceAddress, let to = destinationAddress else { return }
        let requestData = taxiorderNetworkService.makeTaxiPriceRequestModel(from: from, to: to, promoCodes: nil, credit: enteredPoints)
        
        taxiorderNetworkService.requestPrice(requestData: requestData) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            
            case .success(let prices):
                self.taxiPricesData = prices
                self.sumOrder = Double(prices.first?.price ?? 0)
                self.view.orderATaxi()
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - Points

extension MapInteractor {
    
    func getPoints() {
        pointsNetworkService.getPoints {[weak self] result in
            
            guard let self = self else { return }
            switch result {
                
            case .success(let pontsData):
                self.view.showPoints(pontsData.credit)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func saveWastedPoints(_ points: Int) {
        enteredPoints = points
    }
}

//MARK: - Sum

extension MapInteractor {
        
    func setSumOrder(_ value: Double) {
        self.sumOrder = value
    }
}

//MARK: - Promocode discount

extension MapInteractor {
    func setPromocodeDiscount(discount: Int) {
        self.promocodeDiscount = 0.01 * Double(discount)
    }
}

//MARK: - Set selected tariff id

extension MapInteractor {
    func setSelectedTariff(id: Int) {
        selectedTariff = id
    }
}

//MARK: - Add enetered promocode

extension MapInteractor {
    
    func addEnterPromocode(promocode: String) {
        enteredPromocodes.append(promocode)
    }
}


//MARK: - Place Taxi Order

extension MapInteractor {
    
    func placeTaxiOrder() {
        
//        setSelectedPaymentWay()
//        print("from: \(sourceAddress)")
//        print("to: \(destinationAddress)" )
//        print("Selected tariff id: \(selectedTariff!)")
//        print("Entered points: \(enteredPoints ?? 0)")
//        print("Entered promocodes: \(enteredPromocodes)")
//        print("Payment way: \(paymentWay) card id: \(paymentCardId)")
        
        guard let from = sourceAddress, let to = destinationAddress, let tariffId = selectedTariff else { return }
        
        let requestedData = taxiorderNetworkService.makePlaceOrderRequestModel(tariff: tariffId,
                                                                     from: from,
                                                                     to: to,
                                                                     paymentCardId: paymentCardId,
                                                                     paymentMethod: paymentWay,
                                                                     promoCodes: enteredPromocodes.isEmpty ? nil : enteredPromocodes,
                                                                     credit: enteredPoints)
        startTimer(timeInterval: 15) { [weak self] _ in
            guard let self = self else { return }
            print("Timer run")
            if !self.isTaxiFound {
                self.placeTaxiOrder()
                self.view.changeWaitingTaxiStateLabelText()
            } else {
                self.timer?.invalidate()
                self.isTaxiFound = false
                print("Timer has been invalidating")
                return
            }
        }
        
        taxiorderNetworkService.placeTaxiOrder(requestData: requestedData) {[weak self] result in
            guard let self = self else { return }
            switch result {
            
            case .success(let taxiOrderResponseData):
                self.isTaxiFound = true
                print(taxiOrderResponseData)
                self.taxiOrderResponseData = taxiOrderResponseData
            case .failure(let error):
                print(error.localizedDescription)
                
                guard let error = error as? ServerErrors else { return }
                
                switch error.statusCode {
                case 404:
                    self.taxiNotFoundCount += 1
                    
                    if self.taxiNotFoundCount > Int.random(in: 1...10) {
                        self.isTaxiFound = true
                        self.taxiOrderResponseData = TaxiPlaceOrderResponseModel.makeTaxiPlaceOrderResponseModel(from: self.sourceAddress ?? "",
                                                                                                                 to: self.destinationAddress ?? "",
                                                                                                                 credit: self.enteredPoints ?? 0, price: Int(self.finalSumOrder))
                    }
                    
                    if self.taxiNotFoundCount == 6 {
                        self.view.driversNotFound()
                    }
                    
                    print("Taxi not found count: \(self.taxiNotFoundCount)")
                default:
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension MapInteractor {
    
    func cancelAnOrder() {
        
    }
}