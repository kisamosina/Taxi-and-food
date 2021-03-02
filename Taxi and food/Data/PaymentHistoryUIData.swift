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
        case description = "Разнообразный и богатый опыт говорит нам, что повышение уровня гражданского сознания способствует повышению качества существующих финансовых и административных условий. Предварительные выводы неутешительны: понимание сути ресурсосберегающих технологий предопределяет высокую востребованность дальнейших направлений развития."
        case searchBarPlaceholder = "Введите искомую сумму"
    }
    
    private enum EngTexts: String {
        case emptyLabelText = "It's empty here for now..."
        case rub = " rub."
        case payment = "Payment № "
        case description = "Diverse and rich experience tells us that raising the level of raising the level of civic awareness improves the quality of financial and administrative conditions. The preliminary conclusions are disappointing: understanding the essence of resource-saving technologies predetermines the demand for further development."
        case searchBarPlaceholder = "Enter searching sum"
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
    
    static var description: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.description.rawValue
        case .eng:
            return EngTexts.description.rawValue
        }

    }
    
    static var searchBarPlaceholder: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.searchBarPlaceholder.rawValue
        case .eng:
            return EngTexts.searchBarPlaceholder.rawValue
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

enum PaymentHistoryDetailViewUIData: CGFloat {
    case width = 324
    case height = 345
}

enum PaymentHistoryViewControllerStates {
    case normal
    case searched ([PaymentsHistoryResponseData])
}
