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
        
        guard let user = PersistanceStoreManager.shared.getUserData()?[0] else { return }
        let path = PromoDescriptionPath.path.rawValue.getServerPath(for: Int(user.id)).getPromo(by: type)

        let resource = Resource<PromoResponse>(path: path, requestType: .GET)

        NetworkService.shared.makeRequest(for: resource, completion:  {[weak self] result in
            guard let self = self else { return }
            switch result {

            case .success(let promoResponse):
                print(promoResponse.data)
                self.promos = promoResponse.data
                self.view.reload()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

