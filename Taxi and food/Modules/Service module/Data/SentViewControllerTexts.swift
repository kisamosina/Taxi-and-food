//
//  SentViewControllerTexts.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 19.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct SentViewControllerTexts: TranslatableTexts {
    
    static var searchTaxiContinueHeader: String {
        switch lang {
        
        case .rus:
            return "Мы продолжим поиск"
        case .eng:
            return "We will conitnue searching"
        }
    }
    
    static var searchTaxiTextBody: String {
        switch lang {
            
        case .rus:
            return "Как только появится подходящий для вас вариант, вы получите уведомление."
        case .eng:
            return "As soon as the option suitable for you, you will receive a notice."
        }
    }
    
    static var cancelationTaxiOrderHeader: String {
        switch lang {
            
        case .rus:
            return "Вы отменили заказ"
        case .eng:
            return "You have canceled the order"
        }
    }
    
    static var cancelationTaxiOrderTextBody: String {
        switch lang {
            
        case .rus:
            return "Вы всегда можете совершить другой заказ, либо сообщить нам о возникшей проблеме."
        case .eng:
            return "You can always make another order, or inform us about the problem."
        }
    }

    static var cancelationTaxiOrderNavTitle: String {
        switch lang {
            
        case .rus:
            return "Отмена заказа"
        case .eng:
            return "Order cancelation"
        }

    }
    
    static var searchTaxiContinueNavTitle: String {
        switch lang {
        
        case .rus:
            return "Поиск в фоновом режиме"
        case .eng:
            return "Search in the background"
        }
    }
}
