//
//  MapInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import UIKit

protocol MapInteractorProtocol: class {
    var view: MapViewProtocol! { get }
    var mapMenuData: [MapMenuSection] { get }
    
    var promos: [PromoShortData]? { get }
    

    init(view: MapViewProtocol)
    
    func getTarifs()
    func getAllPromos()
    
    func isPromoAvailableByTime(timeFrom: String, timeTo: String) -> Bool
   
}

class MapInteractor: MapInteractorProtocol {
  
 
    var promos: [PromoShortData]?
    
   
    
    
    internal weak var view: MapViewProtocol!
    
    var mapMenuData: [MapMenuSection] {
        return MapMenuData.getMapMenuSections()
    }
    
    required init(view: MapViewProtocol) {
        self.view = view
    }

    func getTarifs() {
        
//        guard let user = PersistanceStoreManager.shared.getUserData()?[0] else { return }
        let path = TariffServerPath.path.rawValue.getServerPath(for: 3)
        
        let resource = Resource<PromoResponse>(path: path, requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource) {[weak self] result in
            guard let self = self else { return }
            switch result {
            
            case .success(let tariffResponse):
                self.promos = tariffResponse.data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
     func getAllPromos() {

         let path = AllPromoServerPath.path.rawValue.getServerPath(for: 3)
         print("path")
         print(path)

         let resource = Resource<PromoResponse>(path: path, requestType: .GET)

         NetworkService.shared.makeRequest(for: resource) {[weak self] result in
             guard let self = self else { return }
             switch result {

             case .success(let promoResponse):
                self.promos = promoResponse.data
                self.view.updateData()
                 print(promoResponse.data)


             case .failure(let error):
                 print(error.localizedDescription)
             }
         }

     }
    
    public func isPromoAvailableByTime(timeFrom: String, timeTo: String) -> Bool {
            
            var bool = false
            let date = Date()
        
        print("mydate")
        print(date)

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
                print("true")
                bool = true
            }

            return bool
            
        }
      
}
