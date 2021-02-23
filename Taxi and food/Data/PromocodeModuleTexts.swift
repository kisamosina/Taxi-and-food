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
    }
    
    internal enum EngTexts: String, CaseIterable {
        case vcTitle = "Enter Promocode"
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
