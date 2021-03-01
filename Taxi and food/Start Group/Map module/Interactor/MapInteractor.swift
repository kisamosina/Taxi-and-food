//
//  MapInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol MapInteractorProtocol: class {
    var view: MapViewProtocol! { get }
    var mapMenuData: [MapMenuSection] { get }
    
    init(view: MapViewProtocol)
    
    func getTarifs()   
    
}

class MapInteractor: MapInteractorProtocol {
    
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
        
        let resource = Resource<TariffResponse>(path: path, requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource) {[weak self] result in
            guard let self = self else { return }
            switch result {
            
            case .success(let tariffResponse):
                self.view.showTariffPageVieController(tariffResponse.data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
