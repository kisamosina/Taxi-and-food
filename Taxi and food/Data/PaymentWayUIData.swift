//
//  PaymentWayUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 06.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

enum PaymentWayStringData: String {
    case paymentWayCellReuseId = "PaymentWayCell"
}

struct PaymentWayTexts {
    
    private enum RusTexts: String {
        case vcTitle = "Способ оплаты"
    }
    
    private enum EngTexts: String {
        case vcTitle = "Payment way"
    }
    
    private enum RusTableTexts: String, CaseIterable {
        case cash = "Наличные"
        case bankCard = "Банковская карта"
        case applePay = "Apple Pay"
        case points = "Баллы"
        case addCard = "Добавить карту"
    }
    
    private enum EngTableTexts: String, CaseIterable {
        case cash = "Cash"
        case bankCard = "Bank card"
        case applePay = "Apple Pay"
        case points = "Points"
        case addCard = "Add a card"
    }
    
    static var cash: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTableTexts.cash.rawValue
        case .eng:
            return EngTableTexts.cash.rawValue
        }
    }
    
    static var bankCard: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTableTexts.bankCard.rawValue
        case .eng:
            return EngTableTexts.bankCard.rawValue
        }
    }
    
    static var applePay: String {
            
            switch UserDefaults.standard.getAppLanguage() {
                
            case .rus:
                return RusTableTexts.applePay.rawValue
            case .eng:
                return EngTableTexts.applePay.rawValue
            }
        }

    static var points: String {
            
            switch UserDefaults.standard.getAppLanguage() {
                
            case .rus:
                return RusTableTexts.points.rawValue
            case .eng:
                return EngTableTexts.points.rawValue
            }
        }

    static var addCard: String {
            
            switch UserDefaults.standard.getAppLanguage() {
                
            case .rus:
                return RusTableTexts.addCard.rawValue
            case .eng:
                return EngTableTexts.addCard.rawValue
            }
        }

    static var initialTableViewTitles: [String] {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTableTexts.allCases.filter {$0 != .addCard }.map{ $0.rawValue }
        case .eng:
            return EngTableTexts.allCases.filter {$0 != .addCard }.map{ $0.rawValue }
        }
    }
    
    static var vcTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.vcTitle.rawValue
        case .eng:
            return EngTexts.vcTitle.rawValue
        }
    }

}
