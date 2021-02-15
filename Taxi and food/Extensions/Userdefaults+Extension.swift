//
//  Userdefaults+Extension.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 15.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func getAppLanguage() -> AppLanguages {
        guard  let language = string(forKey: AppSettingsStorageKeys.language.rawValue) else {
            self.set(AppLanguages.rus.rawValue, forKey: AppSettingsStorageKeys.language.rawValue)
            return .rus
        }
        
        return AppLanguages.getLanguage(language)
    }
    
    func storeLanguage(_ language: String) {
        self.set(language, forKey: AppSettingsStorageKeys.language.rawValue)
    }
    
    
}
