//
//  SettingsModuleUIData.swift
//  Taxi and food
//
//  Created by mac on 18/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct SettingsViewControllerText {
    
    internal enum RusNavigationItemTitleText: String {
        case navigationItemTextRu = "Настройки"
        
    }
    
    internal enum EngNavigationItemTitleText: String {
        case navigationItemTextEn = "Settings"
        
    }
    
    internal enum RusHeaderTitleText: String {
        case navigationItemTextRu = "Автоматическое обновление данных геолокации"
        
    }
    
    internal enum EngHeaderTitleText: String {
        case navigationItemTextEn = "Geolocation data auto-update"
        
    }
    
    internal enum RusLanguageCellTitleText: String {
        case rusLanguageRu = "Русский"
        case engLanguageRu = "English"
        
    }
    
    internal enum EngLanguageCellTitleText: String {
        case rusLanguageEng = "Russian"
        case engLanguageEng = "English"
    }
    
    
    
    internal enum RusCellTitleText: String {
        case languageRu = "Язык"
        case personalDataRu = "Персональные данные"
        case pushRu = "Push-уведомление вместо звонка"
        case promoNotificationRu = "Уведомленя об акциях"
        case availablePromoRu = "Доступные акции"
        case refreshRu = "Обновлять по сотовой сети"
        
    }
    
    internal enum EngCellTitleText: String {
        case languageEn = "Language"
        case personalDataEn = "Personal data"
        case pushEn = "Push notification instead of a call"
        case promoNotificationEn = "Promo notification"
        case availablePromoEn = "Available promos"
        case refreshEn = "Refresh over cellular network"
    }
    
    static var navigationItemTitleText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusNavigationItemTitleText.navigationItemTextRu.rawValue
        
        case .eng:
            return EngNavigationItemTitleText.navigationItemTextEn.rawValue
        }
        
    }
    
    static var headerTitleText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusHeaderTitleText.navigationItemTextRu.rawValue
        
        case .eng:
            return EngHeaderTitleText.navigationItemTextEn.rawValue
        }
        
    }
    
    static var languageCellTitleText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusCellTitleText.languageRu.rawValue
        
        case .eng:
            return EngCellTitleText.languageEn.rawValue
        }
        
    }
    
    static var personalDataCellTitleText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusCellTitleText.personalDataRu.rawValue
        
        case .eng:
            return EngCellTitleText.personalDataEn.rawValue
        }
        
    }
    
    static var pushCellTitleText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusCellTitleText.pushRu.rawValue
        
        case .eng:
            return EngCellTitleText.pushEn.rawValue
        }
        
    }
    
    static var promoNotificationCellTitleText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusCellTitleText.promoNotificationRu.rawValue
        
        case .eng:
            return EngCellTitleText.promoNotificationEn.rawValue
        }
        
    }
    
    static var availablePromoCellTitleText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusCellTitleText.availablePromoRu.rawValue
        
        case .eng:
            return EngCellTitleText.availablePromoEn.rawValue
        }
        
    }
    
    static var refreshCellTitleText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusCellTitleText.refreshRu.rawValue
        
        case .eng:
            return EngCellTitleText.refreshEn.rawValue
        }
        
    }
    
    static var rusLanguageCellTittleText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusLanguageCellTitleText.rusLanguageRu.rawValue
        case .eng:
            return EngLanguageCellTitleText.rusLanguageEng.rawValue
        }
    }
    
    static var engLanguageCellTittleText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusLanguageCellTitleText.engLanguageRu.rawValue
        case .eng:
            return EngLanguageCellTitleText.engLanguageEng.rawValue
        }
    }
    
    
    
    
}
