//
//  TaxiHasFoundViewTexts.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct TaxiHasFoundViewTexts: TranslatableTexts {
    
    private enum RusTaxiHasFoundViewTexts: String {
        case driver = "Водитель:"
        case feedTime = "Время подачи:"
    }
    
    private enum EngTaxiHasFoundViewTexts: String {
        case driver = "Driver:"
        case feedTime = "Feed time:"
    }
    
    static var driver: String {
        switch lang {
        
        case .rus:
            return RusTaxiHasFoundViewTexts.driver.rawValue
        case .eng:
            return EngTaxiHasFoundViewTexts.driver.rawValue
        }
    }
    
    static var feedTime: String {
        switch lang {
            
        case .rus:
            return RusTaxiHasFoundViewTexts.feedTime.rawValue
        case .eng:
            return EngTaxiHasFoundViewTexts.feedTime.rawValue
        }
    }
}
