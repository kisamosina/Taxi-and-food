//
//  PersonalAccountUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 03.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

enum PersonalAccountCellStringData: String {
    case id = "PersonalAccountCell"
}

struct PersonalAccountViewControllerTexts {
    
    private enum RusTexts: String {
        case title = "Личный кабинет"
        case LogoutButtonTitle = "Выйти"
    }
    
    private enum EngTexts: String {
        case title = "Personal account"
        case LogoutButtonTitle = "Log out"
    }
    
    private enum RusTableViewTexts: String, CaseIterable {
        case MyAddresses = "Мои адреса"
        case PaymentHistory = "История платежей"
        case OrderHistory = "История заказов"
        case PaymentWay = "Способ оплаты"
        
    }
    
    private enum EngTableViewTexts: String, CaseIterable {
        case MyAddresses = "My addresses"
        case PaymentHistory = "Payment History"
        case OrderHistory = "Order History"
        case PaymentWay = "Payment way"
    }
    
    static var myAddresses: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTableViewTexts.MyAddresses.rawValue
        case .eng:
            return EngTableViewTexts.MyAddresses.rawValue
        }
    }
    
    static var paymentHistory: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTableViewTexts.PaymentHistory.rawValue
        case .eng:
            return EngTableViewTexts.PaymentHistory.rawValue
        }
    }

    static var paymentWay: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTableViewTexts.PaymentWay.rawValue
        case .eng:
            return EngTableViewTexts.PaymentWay.rawValue
        }
    }
    
    static var tableViewTextData: [String] {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTableViewTexts.allCases.map { $0.rawValue }
        case .eng:
            return EngTableViewTexts.allCases.map { $0.rawValue }
        }
    }
    
    static var vcTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTexts.title.rawValue
        case .eng:
            return EngTexts.title.rawValue
        }
    }
    
    static var logoutButtonTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTexts.LogoutButtonTitle.rawValue
        case .eng:
            return EngTexts.LogoutButtonTitle.rawValue
        }
    }

}


enum PersonalAccountViewControllerSegues {
    case PaymentHistory
    case PaymentWay
    case MyAddresses
    case unknown
    
    static func getCase(from text: String) -> PersonalAccountViewControllerSegues {
        switch text {
        case PersonalAccountViewControllerTexts.paymentHistory:
            return .PaymentHistory
        case PersonalAccountViewControllerTexts.paymentWay:
            return .PaymentWay
        case PersonalAccountViewControllerTexts.myAddresses:
            return .MyAddresses
        default:
            return unknown
        }
    }
}
