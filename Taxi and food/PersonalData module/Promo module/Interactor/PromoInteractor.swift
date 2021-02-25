//
//  PromoInteractor.swift
//  Taxi and food
//
//  Created by mac on 25/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PromoInteractorProtocol {
    var view: PromoViewProtocol! { get }
    var models: [PromoOption] { get set }
    
    init(view: PromoViewProtocol)
    
    func configure()
}

class PromoInteractor: PromoInteractorProtocol {
    
    var models: [PromoOption] = [PromoOption]()
    
    internal weak var view: PromoViewProtocol!
    
    required init(view: PromoViewProtocol) {
        self.view = view
    }
    
    func configure() {
        models.append(PromoOption(title: PromoViewControllerText.foodNameLabelTitleText))
        models.append(PromoOption(title: PromoViewControllerText.taxiNameLabelTitleText))
    }
    
    }
