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
    
    func viewHeight() -> CGFloat {
        switch self {
        case .address:
            return FullPathViewSizes.heightWhenAddress.rawValue
        case .withTariff:
            return FullPathViewSizes.heightWhenWithTariff.rawValue
        }
    }
}



struct FullPathViewTexts {
    
    private enum RusTexts: String {
        case duration = "мин"
        case cost = "руб"
    }
    
    private enum EngTexts: String {
        case duration = "min"
        case cost = "rub"
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


