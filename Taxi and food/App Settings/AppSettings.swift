//
//  AppSettings.swift
//  Ride and food
//
//  Created by Maxim Alekseev on 10.02.2021.
//

import Foundation

final class AppSettings {
    
    enum Languages: String {
        case rus
        case en
    }
    
    private enum AppSetupKeys: String {
        case language
    }
    
    static let shared: AppSettings = AppSettings()
    
    private let userDefaults = UserDefaults.standard
    var language: Languages  = .rus
    
    private init() {}
    
    private func getCaseFromString(_ string: String) -> Languages  {
        switch string {
        case "rus": return .rus
        default: return .en
        }
    }


    //Store data in user defaults
    func storeData() {
        
        userDefaults.set(self.language.rawValue, forKey: AppSetupKeys.language.rawValue)
        
    }
    
        
    //Get data from user defaults
    func getSettingsDataFromStorage() {
        
        if let langugeString = userDefaults.string(forKey: AppSetupKeys.language.rawValue) {
            self.language = self.getCaseFromString(langugeString)
        } else {
            self.language = .rus
        }
    }
    
}
