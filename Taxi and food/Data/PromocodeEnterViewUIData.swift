//
//  PromocodeEnterViewUIData.swift
//  Taxi and food
//
//  Created by mac on 15/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum PromocodeEnterViewStringData: String {
    case nibName = "PromocodeEnterView"
}

enum PromocodeEnterViewSize: CGFloat {
    case height = 260
}

enum PromocodeEnterViewType {
    case promo
    case points
    
}

struct PromocodeEnterViewTexts {
    
    private enum RusTexts: String {
        case promoPlaceholder = "Введите промокод"
        case pointsPlaceholder = "Введите количество баллов"
    }
    
    private enum EngTexts: String {
        case promoPlaceholder = "Enter promocode"
        case pointsPlaceholder = "Enter the number of points"
        
    }
    
    static var promoPlaceholderText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusTexts.promoPlaceholder.rawValue
        case .eng:
            return EngTexts.promoPlaceholder.rawValue
        }
    }
    static var pointsPlaceholderText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusTexts.pointsPlaceholder.rawValue
        case .eng:
            return EngTexts.pointsPlaceholder.rawValue
        }
    }
}



