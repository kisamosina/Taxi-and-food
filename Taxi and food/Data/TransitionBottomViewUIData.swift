//
//  TransitionBottomViewUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 09.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum TransitionBottomViewTypes {
    case cardApprovement(String)
}

enum TransitionBottomViewSizes: CGFloat {
    case shadowOpacity = 1
    case cornerRadius = 20
    case shadowOffsetHeight = 2
    case shadowOffsetWidth = 2.01
    case descriptionLabelFontSize = 12
}

enum TransitionBottomViewStringData: String {
    case nibName = "TransitionBottomView"
}

struct TransitionBottomViewTexts {
    
    static var approvementTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return "Подтверждение"
        case .eng:
            return "Approvement"
        }
    }
    
    static var approvementDescription: String {
       
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            
            return "Для подтверждения платёжеспособности с карты $ будет списан 1 руб. Сумма будет возвращена сразу после подтверждения из банка."
        case .eng:
            
            return "To confirm the platform from the card $, 1 rub will be written off. The amount will be returned immediately after confirmation from the bank."
        }

    }
    
}
