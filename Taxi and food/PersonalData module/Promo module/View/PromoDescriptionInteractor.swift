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
    
    
    
}

class PromoDescriptionInteractor: PromoDescriptionIneractorProtocol {

    
    

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
    
    
   
}
