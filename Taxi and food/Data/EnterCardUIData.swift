//
//  EnterCardUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 08.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

struct CardEnterViewTexts {
    
    private enum RusTexts: String {
        case cardNumberPlaceholderText = "Номер карты"
        case datePlaceholderText = "Срок"
        case cvcPlaceHolderText = "CVV"
    }
    
    private enum EngTexts: String {
        case cardNumberPlaceholderText = "Card number"
        case datePlaceholderText = "Expire date"
        case cvcPlaceHolderText = "CVV"
    }
    
    static var cardNumberPlaceholderText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTexts.cardNumberPlaceholderText.rawValue
        case .eng:
            return EngTexts.cardNumberPlaceholderText.rawValue
        }
    }
    
    static var datePlaceholderText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTexts.datePlaceholderText.rawValue
        case .eng:
            return EngTexts.datePlaceholderText.rawValue
        }
    }
    
    static var cvcPlaceHolderText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTexts.cvcPlaceHolderText.rawValue
        case .eng:
            return EngTexts.cvcPlaceHolderText.rawValue
        }
    }
}

enum CardEnterViewUIData: CGFloat {
    case shadowOpacity = 1
    case cornerRadius = 20
    case shadowOffsetHeight = 2
    case shadowOffsetWidth = 2.01
    case upViewHeight = 5
}
