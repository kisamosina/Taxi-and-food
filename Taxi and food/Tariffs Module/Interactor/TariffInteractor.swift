//
//  TarifInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 17.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol TariffInteractorProtocol: AnyObject {
    var view: TariffViewProtocol? { get }
    var tariff: TariffData { get }
    var tariffsNames: [String] { get }
    var page: Int { get }
    var tariffColor: UIColor { get }
    
    init(view: TariffViewProtocol, tariff: TariffData, tariffsNames: [String], page: Int)
    
    func makeTariffsButtons() -> [TariffTitleButton]
}

class TariffInteractor: TariffInteractorProtocol {
    
    internal weak var view: TariffViewProtocol?
    
    var tariff: TariffData
    var tariffsNames: [String]
    var page: Int
    var tariffColor: UIColor {
        
        switch TariffsNames.getTariffCase(for: tariff.name) {
        
        case .Standart:
            return Colors.tariffGreen.getColor()
        case .Premium:
            return Colors.tariffPurple.getColor()
        case .Business:
            return Colors.tariffGold.getColor()
        case .unknown:
            return Colors.buttonGrey.getColor()
        }
    }
    
    required init(view: TariffViewProtocol, tariff: TariffData, tariffsNames: [String], page: Int) {
        self.view = view
        self.tariff = tariff
        self.tariffsNames = tariffsNames
        self.page = page
    }
    
    func makeTariffsButtons() -> [TariffTitleButton] {
        
        return tariffsNames.map { [unowned self] name in
            
            let button = TariffTitleButton(title: name)
            
            if name == self.tariff.name {
                button.setColor(tariffColor)
            }
            
            return button
        }
    }
}
