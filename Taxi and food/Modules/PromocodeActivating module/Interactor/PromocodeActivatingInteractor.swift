//
//  PromocodeActivatingInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 29.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import UIKit

class PromocodeActivatingInteractor: PromocodeActivatingInteractorProtocol {
    
    weak var view: PromocodeActivatingViewProtocol!
    
    private weak var promocodeService: PromocodeNetworkServiceProtocol!
    
    func initView(_ view: PromocodeActivatingViewProtocol) {
        self.view = view
        self.promocodeService = PromocodeNetworkService.shared
    }
    
    func promocodeActivate(promocode: String) {
        
        promocodeService.requestPromocodeActivate(code: promocode) {[weak self] result in
            
            guard let self =  self else { return }
            
            switch result {
            
            case .success(let data):
                self.view.promocodeActivated(description: data.description)
            case .failure(let error):
                if let serverError = error as? ServerErrors {
                    switch serverError.statusCode {
                     case 403:
                        self.view.promocodeAlreadyActivated()
                    default:
                        self.view.invalidPromocode()
                    }
                }
            }
            
        }
    }
}
