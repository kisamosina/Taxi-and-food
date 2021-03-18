//
//  AlertControllerUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 16.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct AlertControllerTexts {
    
    private enum RusTexts: String {
        case Settings = "Настройки"
        case Cancel = "Отмена"
        case Attention = "Внимание"
    }
    
    private enum EngTexts: String {
        case Settings
        case Cancel
        case Attention
    }
    
    static var settingsText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTexts.Settings.rawValue
        case .eng:
            return EngTexts.Settings.rawValue
        }
        
    }
    
    static var cancelText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTexts.Cancel.rawValue
        case .eng:
            return EngTexts.Cancel.rawValue
        }
    }
    
    static var attentionText: String {
            
            switch UserDefaults.standard.getAppLanguage() {
            
            case .rus:
                return RusTexts.Attention.rawValue
            case .eng:
                return EngTexts.Attention.rawValue
            }
            
        }
}
