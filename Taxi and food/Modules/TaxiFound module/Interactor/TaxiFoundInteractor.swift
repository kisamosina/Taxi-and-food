//
//  TaxiHasFoundInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

class TaxiFoundInteractor: TaxiFoundInteractorProtocol {
    
    let taxiPlaceOrderResponse: TaxiPlaceOrderResponseModel
    
    weak var view: TaxiFoundViewProtocol!
    
    required init(taxiPlaceOrderResponse: TaxiPlaceOrderResponseModel) {
        self.taxiPlaceOrderResponse = taxiPlaceOrderResponse
    }
    
    func initView(_ view: TaxiFoundViewProtocol) {
        self.view = view
    }
}
