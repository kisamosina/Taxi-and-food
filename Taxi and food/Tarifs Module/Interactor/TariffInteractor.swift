//
//  TarifInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 17.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol TariffInteractorProtocol: class {
    var view: TariffViewProtocol? { get }
    var tariff: TariffData { get }
    var page: Int { get }
    init(view: TariffViewProtocol, tariff: TariffData, page: Int)
    }

class TariffInteractor: TariffInteractorProtocol {
    
    internal weak var view: TariffViewProtocol?
    
    var tariff: TariffData
    var page: Int
    
    required init(view: TariffViewProtocol, tariff: TariffData, page: Int) {
        self.view = view
        self.tariff = tariff
        self.page = page
    }
}
