//
//  WaitingTaxiViewTexts.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 18.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct WaitingTaxiViewTexts {
    
    private static var language: AppLanguages {
        return UserDefaults.standard.getAppLanguage()
    }
    
    static var stateSearchAnOption: String {
        switch language {
            
        case .rus:
            return "Ищем подходящий вариант"
        case .eng:
            return "We are looking for a suitable option"
        }
    }
    
    static var waitAWhile: String {
        switch language {
            
        case .rus:
            return "Подождите ещё немного"
        case .eng:
            return "Wait a little more"
        }
    }
}
