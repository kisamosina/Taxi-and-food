//
//  PromocodeModuleTexts.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 23.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

enum PromocodeViewControllerSegues {
    case enterPromocode
    case showHistory
    case unknown
}

struct PromocodeViewControllerTexts {

    internal enum RusTexts: String, CaseIterable {
        case enterPromocode = "Ввести промокод"
        case usingHistory = "История использования"
        case unknown
        static func getCase(_ text: String) -> RusTexts {
            switch text {
            
            case RusTexts.enterPromocode.rawValue:
                return .enterPromocode
            case RusTexts.usingHistory.rawValue:
                return .usingHistory
            
            default:
                return .unknown
            }
        }
    }
    
    internal enum EngTexts: String, CaseIterable {
        case enterPromocode = "Enter Promocode"
        case usingHistory = "Using history"
        case unknown
        
        static func getCase(_ text: String) -> EngTexts {
            switch text {
            
            case EngTexts.enterPromocode.rawValue:
                return .enterPromocode
            case EngTexts.usingHistory.rawValue:
                return .usingHistory
            
            default:
                return .unknown
            }
        }
    }
    
    static var promocodeChooseCellId: String {
        return "ChoosePromocodeOptionCell"
    }
    
    static var vcTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return "Промокод"
        case .eng:
            return "Promocode"
        }
    }
    
    static var promocodeOptions: [String] {
        
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusTexts.allCases.filter { $0 != .unknown }.map { $0.rawValue }
        case .eng:
            return EngTexts.allCases.filter { $0 != .unknown }.map { $0.rawValue }
        }
    }
    
    static func getSegue(_ text: String) -> PromocodeViewControllerSegues {
        
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            
            let rusTextCase = RusTexts.getCase(text)
            
            switch rusTextCase {
                
            case .enterPromocode:
                return .enterPromocode
                
            case .usingHistory:
                return .showHistory
                
            case .unknown:
                return .unknown
            }
            
        case .eng:
            let engTextCase = EngTexts.getCase(text)
            
            switch engTextCase {
                
            case .enterPromocode:
                return .enterPromocode
                
            case .usingHistory:
                return .showHistory
                
            case .unknown:
                return .unknown
            }

        }
    }
}

struct PromocodeEnterViewControllerTexts {

    internal enum RusTexts: String, CaseIterable {
        case vcTitle = "Ввести промокод"
        case invalidPromocode = "Промокод недействителен"
        case promocodeAlreadyHas = "Промокод уже добавлен"
        case promocodeActivated = "Промокод активирован"
    }
    
    internal enum EngTexts: String, CaseIterable {
        case vcTitle = "Enter Promocode"
        case invalidPromocode = "Invalid promocode"
        case promocodeAlreadyHas = "Promocode already activated"
        case promocodeActivated = "Promocode activated"
    }
    
    static var vcTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.vcTitle.rawValue
        case .eng:
            return EngTexts.vcTitle.rawValue
        }
    }
    
    static var invalidPromocode: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.invalidPromocode.rawValue
        case .eng:
            return EngTexts.invalidPromocode.rawValue
        }
    }

    static var promocodeAlreadyHas: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.promocodeAlreadyHas.rawValue
        case .eng:
            return EngTexts.promocodeAlreadyHas.rawValue
        }
    }
    
    static var promocodeActivated: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.promocodeActivated.rawValue
        case .eng:
            return EngTexts.promocodeActivated.rawValue
        }
    }

}

enum PromocodeHistoryViewControllerStates {
    case active
    case expired
}


struct PromocodeHistoryViewControllerTexts {
    internal enum RusTexts: String {
        case vcTitle = "История использования"
        case segmentControlZeroTitle = "Активные"
        case segmentControlFirstTitle = "Неактивные"
        case warningLabelText = "Обращаем ваше внимание, что скидки по промокодам на аналогичные сервисы не суммируются. На ближайший заказ сработает тот промокод, срок действия которого истекает раньше."
    }
    
    internal enum EngTexts: String {
        case vcTitle = "Using history"
        case segmentControlZeroTitle = "Active"
        case segmentControlFirstTitle = "Nonactive"
        case warningLabelText = "Please pay attetion, promocode discounts on the same services doesn't sum up. On the next order will be work promocode with expiration expire early."
    }
    
    
    static var vcTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.vcTitle.rawValue
        case .eng:
            return EngTexts.vcTitle.rawValue
        }
    }

    static var segmentControlZeroTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.segmentControlZeroTitle.rawValue
        case .eng:
            return EngTexts.segmentControlZeroTitle.rawValue
        }
    }
    
    static var segmentControlFirstTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.segmentControlFirstTitle.rawValue
        case .eng:
            return EngTexts.segmentControlFirstTitle.rawValue
        }
    }

    static var warningLabelText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.warningLabelText.rawValue
        case .eng:
            return EngTexts.warningLabelText.rawValue
        }
    }

    
}
