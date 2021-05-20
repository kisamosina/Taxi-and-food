//
//  TaxiHasFoundInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

class TaxiHasFoundInteractor: TaxiHasFoundInteractorProtocol {
    
    weak var view: TaxiHasFoundViewProtocol!
    
    func initView(_ view: TaxiHasFoundViewProtocol) {
        self.view = view
    }
}
