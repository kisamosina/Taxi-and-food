//
//  PaymentHistoryUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 27.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

struct PaymentHistoryViewControllerTexts {
    
    private enum RusTexts: String {
        case emptyLabelText = "Здесь пока пусто..."
        case rub = " руб."
        case payment = "Платеж № "
    }
    
    private enum EngTexts: String {
        case emptyLabelText = "It's empty here for now..."
        case rub = " rub."
        case payment = "Payment № "
    }
    
    static var emptyLabelText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.emptyLabelText.rawValue
        case .eng:
            return EngTexts.emptyLabelText.rawValue
        }
    }
    
    static var rubText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.rub.rawValue
        case .eng:
            return EngTexts.rub.rawValue
        }
    }
    
    static var paymentText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.payment.rawValue
        case .eng:
            return EngTexts.payment.rawValue
        }
    }

    
}

enum PaymentMethod {
    case master
    case visa
    case unknown
    
    static func getPaymentMetod(from text: String) -> PaymentMethod {
        switch text {
        
        case "MasterCard":
            return .master
            
        case "Visa":
            return .visa
        
        default:
            return .unknown
        }
    }
    
}

enum PaymentHistoryCellViewLayer: CGFloat {
    case shadowOpacity = 1
    case shadowRadius = 10
    case shadowOffsetHeightAndWidth = 1.01
}

enum PaymentHistoryIds: String {
    case PaymentHistoryDetailView
    case id = "PaymentHistoryTableViewCell"
}
