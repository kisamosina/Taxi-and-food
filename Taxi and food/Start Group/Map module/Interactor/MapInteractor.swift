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
}

class MapInteractor: MapInteractorProtocol {
    
    internal weak var view: MapViewProtocol!
    
    var mapMenuData: [MapMenuSection] {
        return MapMenuData.getMapMenuSections()
    }
    
    required init(view: MapViewProtocol) {
        self.view = view
    }

}
