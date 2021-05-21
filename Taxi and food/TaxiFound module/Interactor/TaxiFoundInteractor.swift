//
//  TaxiHasFoundInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

class TaxiFoundInteractor: TaxiFoundInteractorProtocol {
    
    weak var view: TaxiFoundViewProtocol!
    
    func initView(_ view: TaxiFoundViewProtocol) {
        self.view = view
    }
}
