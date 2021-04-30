//
//  PromoInteractor.swift
//  Taxi and food
//
//  Created by mac on 25/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PromoInteractorProtocol: AnyObject {
    var view: PromoViewProtocol! { get }
    
    var models: [PromoOption] { get set }
    
    var allPromos: [PromoShortData] { get set }
    
    init(view: PromoViewProtocol)
    
    func configure()
    
    func getAllPromos()
    
}

class PromoInteractor: PromoInteractorProtocol {
    
    internal weak var view: PromoViewProtocol!
    
    var models: [PromoOption] = []
    
    var allPromos: [PromoShortData] = []
    
    required init(view: PromoViewProtocol) {
        self.view = view
    }
    
    func configure() {
        models.append(PromoOption(title: PromoViewControllerText.foodNameLabelTitleText))
        models.append(PromoOption(title: PromoViewControllerText.taxiNameLabelTitleText))
        
    }
    
    func getAllPromos() {
        
        let path = AllPromoServerPath.path.rawValue.getServerPath(for: 3)
        print("path")
        print(path)

        let resource = Resource<PromoResponse>(path: path, requestType: .GET)

        NetworkService.shared.makeRequest(for: resource, completion:  {[weak self] result in
            guard let self = self else { return }
            switch result {

            case .success(let promoResponse):
                print(promoResponse.data)
                self.allPromos = promoResponse.data
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
   
    }


}

