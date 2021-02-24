//
//  PromocodeHistoryCellUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum PromocodeHistoryCellViewLayer: CGFloat {
    case cornerRadius = 15
    case shadowOpacity = 1
    case shadowRadius = 10
    case shadowOffsetHeightAndWidth = 1.01
}

enum PromocodeHistoryCellViewIds: String {
    case nameAndReuseId = "PromocodeHistoryTableViewCell"
}

struct PromocodeHistoryCellTexts {
    enum RusText: String {
        case expired = "Истек срок действия: "
        case activated = "Промокод был использован: "
        case expireAfter = "Истекает через: "
    }
    
    enum EngText: String {
        case expired = "Expired: "
        case activated = "Promocode had been used: "
        case expireAfter = "Expire after: "
    }
    
    
    static var expiredText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusText.expired.rawValue
        case .eng:
            return EngText.expired.rawValue
        }
    }
    
    static var activatedText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusText.activated.rawValue
        case .eng:
            return EngText.activated.rawValue
        }
    }
    
    static var expireAfterText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusText.expireAfter.rawValue
        case .eng:
            return EngText.expireAfter.rawValue
        }
    }

    
}
