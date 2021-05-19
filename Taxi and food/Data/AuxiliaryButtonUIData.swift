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
    case wasteSomePoints
    case tellAboutProblem
}

struct AuxiliaryButtonTitles: TranslatableTexts {
    
    static var cancelTitle: String {
        switch lang {
        
        case .rus:
            return "Отмена"
        case .eng:
            return "Cancel"
        }
    }
    
    static var aboutTitle: String {
        switch lang {
        
        case .rus:
            return "Подробнее"
        case .eng:
            return "About"
        }
    }
    
    static var wasteSomePointsTitle: String {
        
        switch lang {
        
        case .rus:
            return "Другое количество"
        case .eng:
            return "Waste some points"
        }
    }
    
    static var tellAboutProblem: String {
        switch lang {
        
        case .rus:
            return "Сообщить о проблеме"
        case .eng:
            return "Tell us about problem"
        }
    }

}
