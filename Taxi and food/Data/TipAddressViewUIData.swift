//
//  TipAddressViewUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 26.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

enum TipAddressViewStringData: String {
    case nibName = "TipAddressView"
}

struct TipAddressViewTexts {
    
    private enum RusTexts: String {
        case tipText = "Нажав сюда можно уточнить, как до вас добраться (подъезд, строения рядом или другой ориентир)"
    }
    
    private enum EngTexts: String {
        case tipText = "By clicking here you can clarify how to reach you (entrance, buildings near or another landmark)"
    }
    
    static var tipText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTexts.tipText.rawValue
        case .eng:
            return EngTexts.tipText.rawValue
        }
    }
}
