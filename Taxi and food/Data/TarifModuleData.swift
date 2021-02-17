//
//  TarifModuleData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 17.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum TariffsServiceTextData: String {
    case AdavantageCollectionViewCell
}

struct TariffViewControllerTextData {
    
    //AuthViewController labels rus text
    internal enum RusLabelTexts: String {
        case tariffDescriptionText = "О тарифе"
        case autoNamesText = "Автомобили: "

    }
    
    //AuthViewController labels english text
    internal enum EngLabelTexts: String {
        case tariffDescriptionText =  "About"
        case autoNamesText = "Autos: "
        
    }
    
    static var tariffDescriptionText: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusLabelTexts.tariffDescriptionText.rawValue
        case .eng:
            return EngLabelTexts.tariffDescriptionText.rawValue
        }
    }
    
    static var autoNamesText: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusLabelTexts.autoNamesText.rawValue
        case .eng:
            return EngLabelTexts.autoNamesText.rawValue
        }
    }
}

enum AdvantageViewShadowsData: CGFloat {
    case shadowOpacity = 1
    case shadowRadius = 15
    case shadowOffsetWidth = 0
    case shadowOffsetHeight = 1.01
}

enum AdvantageCollectionViewInsets: CGFloat {
    case widthSumInsets = 75
}
