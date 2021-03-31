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
    case pointsFirstTime(PointsResponseData)
    case points(PointsResponseData)
    case logout
    case deleteAddress
}

enum TransitionBottomViewSizes: CGFloat {
    case shadowOpacity = 1
    case cornerRadius = 20
    case shadowOffsetHeight = 2
    case shadowOffsetWidth = 2.01
    case descriptionLabelFontSize = 12
    case firstPointsUseHeight = 330
    case whenPointsHeght = 260
    case deleteAddressHeight = 270
    case findAddressView = 386
    
}

enum TransitionBottomViewStringData: String {
    case nibName = "TransitionBottomView"
}

struct TransitionBottomViewTexts {
    
    static var findAddressPlaceholderTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return "Введите адрес доставки"
        case .eng:
            return "Enter delivery address"
        }
    }

    
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
    
    static var congratulationText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return "Поздравляем! 🎉"
        case .eng:
            return "Congratulations! 🎉"
        }
    }
    
    static var youHaveNPointsText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return "У вас $ бонусных баллов"
        case .eng:
            return "You have $ bounucing points"
        }

    }
    
    static var shortPointsDescription: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return "Количество баллов всегда можно посмотреть в данном разделе, либо при оплате заказа"
        case .eng:
            return "The number of points can always be viewed in this section, or when paying for the order"
        }
    }
    
    static var logoutTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return "Выйти из приложения?"
        case .eng:
            return "Log Out from aplication?"
        }
    }
    
    static var deleteAddressTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return "Удалить адрес?"
        case .eng:
            return "Delete address?"
        }
    }
    
}
