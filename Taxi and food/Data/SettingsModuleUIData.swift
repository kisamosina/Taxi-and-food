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
    
    static var navigationItemTitleText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusNavigationItemTitleText.navigationItemTextRu.rawValue
        
        case .eng:
            return EngNavigationItemTitleText.navigationItemTextEn.rawValue
        }
        
    }
}
