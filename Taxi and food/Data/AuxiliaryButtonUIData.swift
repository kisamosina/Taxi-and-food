//
//  AuxilaryButtonUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 11.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

enum AuxiliaryButtonTypes {
    case about
    case cancel
}

struct AuxiliaryButtonTitles {
    
    static var cancelTitle: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return "Отмена"
        case .eng:
            return "Cancel"
        }
    }
    
    static var aboutTitle: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return "Подробнее"
        case .eng:
            return "About"
        }
    }

}
