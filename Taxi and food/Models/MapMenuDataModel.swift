//
//  MapMenuDataModel.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

struct MapMenuSection {
    var items: [MapMenuItem]
}

struct MapMenuItem {
    var itemName: String
    var itemImage: UIImage?
    
    init(itemName: String, itemImageName: String? = nil) {
        self.itemName = itemName
        guard let itemImageName = itemImageName
        else { self.itemImage = nil
            return
        }
        self.itemImage = UIImage(named: itemImageName)
    }
    
}

struct MapMenuData {
    
    internal enum RusNames: String, CaseIterable {
        case SupportService = "Служба поддержки"
        case Settings = "Настройки"
        case Payment = "Способ оплаты"
        case Tariffs = "Тарифы"
        case PromoCode = "Промокод"
        case Promo = "Акции"
        case Addresses = "Мои адреса"
        case unknown
        
        static func getCase(from text: String) -> RusNames {
            switch text {
            case RusNames.SupportService.rawValue:
                return .SupportService
            case RusNames.Settings.rawValue:
                return .Settings
            case RusNames.Payment.rawValue:
                return .Payment
            case RusNames.Tariffs.rawValue:
                return .Tariffs
            case RusNames.PromoCode.rawValue:
                return .PromoCode
            case RusNames.Promo.rawValue:
                return .Promo
            case RusNames.Addresses.rawValue:
                return .Addresses
            default:
                return .unknown
            }
        }
    }
    
    internal enum EngNames: String, CaseIterable {
        case SupportService = "Support service"
        case Settings
        case Payment
        case Tariffs
        case PromoCode = "Promo code"
        case Promo = "Promotions"
        case Addresses = "My addresses"
        case unknown
        
        static func getCase(from text: String) -> RusNames {
            switch text {
            case EngNames.SupportService.rawValue:
                return .SupportService
            case EngNames.Settings.rawValue:
                return .Settings
            case EngNames.Payment.rawValue:
                return .Payment
            case EngNames.Tariffs.rawValue:
                return .Tariffs
            case EngNames.PromoCode.rawValue:
                return .PromoCode
            case EngNames.Promo.rawValue:
                return .Promo
            case EngNames.Addresses.rawValue:
                return .Addresses
            default:
                return .unknown
            }
        }
        
    }
    
    static var tariffs: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusNames.Tariffs.rawValue
        case .eng:
            return EngNames.Tariffs.rawValue
        }
    }
    
    static var settings: String {
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusNames.Settings.rawValue
        case .eng:
            return EngNames.Settings.rawValue
        }
    }
    
    static var addresses: String {
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusNames.Addresses.rawValue
        case .eng:
            return EngNames.Addresses.rawValue
        }
    }
    static var service: String {
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusNames.SupportService.rawValue
        case .eng:
            return EngNames.SupportService.rawValue
        }
    }
    
    static var promo: String {
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusNames.Promo.rawValue
        case .eng:
            return EngNames.Promo.rawValue
        }
    }
    
    
    
    static var promocodes: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusNames.PromoCode.rawValue
        case .eng:
            return EngNames.PromoCode.rawValue
        }
    }
    
    static var paymentsWay: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusNames.Payment.rawValue
        case .eng:
            return EngNames.Payment.rawValue
        }
        
    }
    
    
    private static var menuEngItems: [String] {
        return EngNames.allCases.map { $0.rawValue }
    }
    
    private static var menuRusItems: [String] {
        return RusNames.allCases.map { $0.rawValue }
    }
    
    
    private static var section1: [String] {
        
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return menuRusItems.filter { RusNames.getCase(from: $0) == .SupportService ||
                RusNames.getCase(from: $0) == .Settings ||
                RusNames.getCase(from: $0) == .Payment
            }
        case .eng:
            return menuEngItems.filter { EngNames.getCase(from: $0) == .SupportService ||
                EngNames.getCase(from: $0) == .Settings ||
                EngNames.getCase(from: $0) == .Payment
            }
        }
    }
    
    private static var section2: [String] {
        
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return menuRusItems.filter { RusNames.getCase(from: $0) == .Tariffs ||
                RusNames.getCase(from: $0) == .PromoCode ||
                RusNames.getCase(from: $0) == .Promo
            }
        case .eng:
            return menuEngItems.filter { EngNames.getCase(from: $0) == .Tariffs ||
                EngNames.getCase(from: $0) == .PromoCode ||
                EngNames.getCase(from: $0) == .Promo
            }
        }
    }
    
    static func getMapMenuSections() -> [MapMenuSection] {
        
        let sectionOneItems = section1.map{ item -> MapMenuItem in
            if RusNames.getCase(from: item) == .Payment || EngNames.getCase(from: item) == .Payment {
                return MapMenuItem(itemName: item, itemImageName: CustomImagesNames.payment.rawValue)
            } else {
                return MapMenuItem(itemName: item)
            }
        }
        
        let sectionTwoItems = section2.map { item -> MapMenuItem in
            
            if RusNames.getCase(from: item) == .PromoCode || EngNames.getCase(from: item) == .PromoCode {
                return MapMenuItem(itemName: item, itemImageName: CustomImagesNames.promocode.rawValue)
            } else {
                return MapMenuItem(itemName: item)
            }
        }
        
        return[MapMenuSection(items: sectionOneItems), MapMenuSection(items: sectionTwoItems)]
    }
}
