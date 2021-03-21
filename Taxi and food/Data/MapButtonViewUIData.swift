//
//  MapButtonView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 21.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum MapButtonViewStringData: String {
    case nibName = "MapButtonView"
}

enum MapButtonViewSizes: CGFloat {
    case height = 34
    case width = 61
}

struct MapButtonViewText {
    
    private enum RusTexts: String {
        case title = "Карта →"
    }
    
    private enum EngTexts: String {
        case title = "Map →"
    }
    
    static var title: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.title.rawValue
        case .eng:
            return EngTexts.title.rawValue
        }
    }
}
