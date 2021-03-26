//
//  Userdefaults+Extension.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 15.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    //MARK: - Store App Language
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
    
    
    //MARK: - Store using points
    func storeIsNotFirstTimePointsUsing(_ isNotFirst: Bool) {
        self.set(isNotFirst, forKey: AppSettingsStorageKeys.pointsIsFirstTimeUsage.rawValue)
    }
    
    func getIsNotFirstTimePointsUsage() -> Bool {
      return bool(forKey: AppSettingsStorageKeys.pointsIsFirstTimeUsage.rawValue)
    }
    
    //MARK: - Store showing Tip address view
    
    func storeShowingTipAddressView(_ isShowed: Bool) {
        self.set(isShowed, forKey: AppSettingsStorageKeys.tipAddressViewShowing.rawValue)
    }
    
    func getTipAddressViewIsShowed() -> Bool {
      return bool(forKey: AppSettingsStorageKeys.tipAddressViewShowing.rawValue)
    }
}
