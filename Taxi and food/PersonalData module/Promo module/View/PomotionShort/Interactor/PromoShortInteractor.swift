//
//  PromoShortInteractor.swift
//  Taxi and food
//
//  Created by mac on 26/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PromoShortInteractorProtocol: class {
    var view: PromoShortViewProtocol! { get }
    
    var promos: [PromoShortData] { get set }
    
    init(view: PromoShortViewProtocol)
    
    func getPromos(type: String)
    
}

class PromoShortInteractor: PromoShortInteractorProtocol {

    internal weak var view: PromoShortViewProtocol!
    
    var promos: [PromoShortData] = []
    
    required init(view: PromoShortViewProtocol) {
        self.view = view

    }
    
    func getPromos(type: String) {
        
        
//        guard let user = PersistanceStoreManager.shared.getUserData()?[0] else { return }
        let path = AllPromoServerPath.path.rawValue.getServerPath(for: 3).getPromo(by: type)
        print("path")
        print(path)

        let resource = Resource<PromoResponse>(path: path, requestType: .GET)

        NetworkService.shared.makeRequest(for: resource) {[weak self] result in
            guard let self = self else { return }
            switch result {

            case .success(let promoResponse):
                self.promos = promoResponse.data
                self.view.reload()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

