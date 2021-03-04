//
//  PromoDescriptionInteractor.swift
//  Taxi and food
//
//  Created by mac on 28/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation



protocol PromoDescriptionIneractorProtocol: class {
    var view: PromoDescriptionViewProtocol! { get }
    
    var promo: PromoFullData? { get set }
    
    init(view: PromoDescriptionViewProtocol)
    
    func getPromosDescription(for id: Int)
    
    func isPromoAvailableByDate() -> Bool
    
    func isPromoAvailableByTime(timeFrom: String, timeTo: String) -> Bool
  
}

class PromoDescriptionInteractor: PromoDescriptionIneractorProtocol {
    
    var description: String?

    internal weak var view: PromoDescriptionViewProtocol!

    required init(view: PromoDescriptionViewProtocol) {
        self.view = view
    }
    
    var promo: PromoFullData?
    
       
    
    func getPromosDescription(for id: Int) {
        
        let path = PromoDescriptionPath.path.rawValue.getServerPath(for: 3).getPromoDescription(for: id)
        print("path")
        print(path)

        let resource = Resource<PromoResponseFull>(path: path, requestType: .GET)

        NetworkService.shared.makeRequest(for: resource) {[weak self] result in
            guard let self = self else { return }
            switch result {

            case .success(let promoResponse):
                print("promo full data")
                print(promoResponse)
                self.promo = promoResponse.data
                self.view.refresh()
   
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func isPromoAvailableByDate() -> Bool {
        
        var bool = false
        
        let date = Date()

        let promoDate_to = promo?.dateTo ?? ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let promoDate = formatter.date(from: promoDate_to) else { return false }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: promoDate)
        
        guard let finalDate = calendar.date(from:components) else { return false}
        
        if finalDate >= date {
            print("true")
            bool = true
        }
        print(promoDate_to)
        
        print("promoDate_to")
        
        print(promo)
        
        return bool
        
    }
    
   
    
    public func isPromoAvailableByTime(timeFrom: String, timeTo: String) -> Bool {
        
        var bool = false
        let date = Date()
        
        
//        let promoTime_from = promo?.timeFrom ?? ""
//        let promoTime_to = promo?.timeTo ?? ""
        
        
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
