//
//  PromoModuleUIData.swift
//  Taxi and food
//
//  Created by mac on 25/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation


public enum AllPromoServerPath: String {
    case path = "user/$/promotions"
}

public enum TypePromoSetverPath: String {
    case path = "user/$/promotions/"
}

struct PromoViewControllerText {
    

internal enum RusNavigationItemTitleText: String {
    case navigationItemTextRu = "Акции"
}

internal enum EngNavigationItemTitleText: String {
    case navigationItemTextEn = "Promos"
}
    internal enum RusFoodNameLabelTitleText: String {
        case nameLabelTextRu = "Еда"
    }
    
    internal enum EngFoodNameLabelTitleText: String {
        case nameLabelTextEn = "Food"
    }
    
    internal enum RusTaxiNameLabelTitleText: String {
        case nameLabelTextRu = "Такси"
    }
    
    internal enum EngTaxiNameLabelTitleText: String {
        case nameLabelTextEn = "Taxi"
    }

static var navigationItemTitleText: String {
switch UserDefaults.standard.getAppLanguage() {
case .rus:
    return RusNavigationItemTitleText.navigationItemTextRu.rawValue

case .eng:
    return EngNavigationItemTitleText.navigationItemTextEn.rawValue
    }
    
    }
    
    static var foodNameLabelTitleText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusFoodNameLabelTitleText.nameLabelTextRu.rawValue

        case .eng:
            return EngFoodNameLabelTitleText.nameLabelTextEn.rawValue
            }
    }
    
    static var taxiNameLabelTitleText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusTaxiNameLabelTitleText.nameLabelTextRu.rawValue

        case .eng:
            return EngTaxiNameLabelTitleText.nameLabelTextEn.rawValue
            }
    }
}
