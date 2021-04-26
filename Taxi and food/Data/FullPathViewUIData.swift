//
//  FullPathViewUIData.swift
//  Taxi and food
//
//  Created by mac on 12/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum FullPathViewStringData: String {
    case nibName = "FullPathView"
}

enum FullPathViewSizes: CGFloat {
    case heightWhenAddress = 280
    case heightWhenWithTariff = 470

}

enum FullPathViewType {
    case address
    case withTariff
    case whenPoints(String)
    
    func viewHeight() -> CGFloat {
        switch self {
        case .address:
            return FullPathViewSizes.heightWhenAddress.rawValue
        case .withTariff:
            return FullPathViewSizes.heightWhenWithTariff.rawValue
        case .whenPoints:
            return FullPathViewSizes.heightWhenWithTariff.rawValue
        }
    }
}



struct FullPathViewTexts {
    
    private enum RusTexts: String {
        case duration = "мин"
        case cost = "руб"
        case promoLabel = "Промокод"
        case pointsLabel = "Баллы"
        case pointsLabelChanged = "Баллов"
    }
    
    private enum EngTexts: String {
        case duration = "min"
        case cost = "rub"
        case promoLabel = "Promocode"
        case pointsLabel = "Points"
        
        
    }
    
    static var minusPointsText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return "-$ Баллов"
        case .eng:
            return "-$ Points"
        }

    }
    
    static var pointsLabelChanged: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusTexts.pointsLabelChanged.rawValue
        case .eng:
            return EngTexts.pointsLabel.rawValue
        }
    }
    
    static var promoLabel: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusTexts.promoLabel.rawValue
        case .eng:
            return EngTexts.promoLabel.rawValue
        }
    }
    
    static var pointsLabel: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusTexts.pointsLabel.rawValue
        case .eng:
            return EngTexts.pointsLabel.rawValue
        }
    }
    
    
    static var duration: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusTexts.duration.rawValue
        case .eng:
            return EngTexts.duration.rawValue
        }
    }
    
    static var cost: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusTexts.cost.rawValue
        case .eng:
            return EngTexts.cost.rawValue
        }
    }
    
    
}


