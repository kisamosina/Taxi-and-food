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

public enum PromoDescriptionPath: String {
    case path = "user/$/promotion"
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
    
    internal enum RusUnavailableLabelTitleText: String {
        case unavailableLabelTextRu = "На данный момент акция недействительна. Воспользуйтесь ей в указанный временной промежуток"
    }
    
    internal enum EngUnavailableLabelTitleText: String {
        case unavailableLabelTextEn = "The promotion is not available right now. Use it in the specified time period"
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
    
    static var unavailableLabelTitleText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusUnavailableLabelTitleText.unavailableLabelTextRu .rawValue

        case .eng:
            return EngUnavailableLabelTitleText.unavailableLabelTextEn.rawValue
            }
    }
}


