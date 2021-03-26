//
//  OrderHistoryUIData.swift
//  Taxi and food
//
//  Created by mac on 26/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct OrderHistoryViewControllerTexts {
    
    private enum RusTexts: String {
        case emptyLabelText = "Здесь пока пусто..."
        case typeFood = "Еда"
        case typeTaxi = "Такси"
        case rub = " руб."
        case firstSegmentTitle = "Завершённые"
        case secondSegmentTitle = "Отменённые"
        case title = "История заказов"
        case typeFoodLabel = "/Доставка еды"
        case typeTaxiLabel = "/Услуги такси"
        
    }
    
     private enum EngTexts: String {
        case emptyLabelText = "It's empty here for now..."
        case typeFood = "Food"
        case typeTaxi = "Taxi"
        case rub = " руб."
        case firstSegmentTitle = "Completed"
        case secondSegmentTitle = "Canceled"
        case title = "Order history"
        case typeFoodLabel = "/Food order"
        case typeTaxiLabel = "/Taxi order"
    }
    
    static var emptyLabelText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.emptyLabelText.rawValue
        case .eng:
            return EngTexts.emptyLabelText.rawValue
        }
    }
    
    static var typeFood: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.typeFood.rawValue
        case .eng:
            return EngTexts.typeFood.rawValue
        }
    }
    
    static var typeTaxi: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.typeTaxi.rawValue
        case .eng:
            return EngTexts.typeTaxi.rawValue
        }
    }
    
    static var rubText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.rub.rawValue
        case .eng:
            return EngTexts.rub.rawValue
        }
    }
    
    static var firstSegmentTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.firstSegmentTitle.rawValue
        case .eng:
            return EngTexts.firstSegmentTitle.rawValue
        }
    }
    
    static var secondSegmentTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.secondSegmentTitle.rawValue
        case .eng:
            return EngTexts.secondSegmentTitle.rawValue
        }
    }
    
    static var title: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.title.rawValue
        case .eng:
            return EngTexts.title.rawValue
        }
    }
    
    static var typeFoodLabel: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.typeFoodLabel.rawValue
        case .eng:
            return EngTexts.typeFoodLabel.rawValue
        }
    }
    
    static var typeTaxiLabel: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.typeTaxiLabel.rawValue
        case .eng:
            return EngTexts.typeTaxiLabel.rawValue
        }
    }
    
}

enum OrderHistoryIds: String {
    case id = "OrderHistoryTableViewCell"
}

enum OrderHistoryViewControllerStates {
    case done
    case canceled 
}

enum OrderHistoryType {
    case food
    case taxi
}


enum OrderType {
    case food
    case taxi
    case unknown

    
    static func getOrderType(from text: String) -> OrderType {
        switch text {
        
        case "food":
            return .food
            
        case "taxi":
            return .taxi
    
        default:
            return .unknown
        }
    }
    
}

enum OrderStatusType {
    case done
    case canceled
    case unknown

    
    static func getOrderStatusType(from text: String) -> OrderStatusType {
        switch text {
        
        case "done":
            return .done
            
        case "canceled":
            return .canceled
    
        default:
            return .unknown
        }
    }
    
}
