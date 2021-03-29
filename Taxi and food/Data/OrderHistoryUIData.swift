//
//  OrderHistoryUIData.swift
//  Taxi and food
//
//  Created by mac on 26/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit


struct OrderHistoryDetailViewTexts {
    
    private enum RusTexts: String {
        case from = "От: "
        case to = "До: "
        case driver = "Водитель: "
        case car = "Автомобиль: "
        case number = "Номер: "
        case time = "Время в пути: "
        case payment = "Платеж № "
        case orderList = "Состав заказа: "
        case store = "Магазин: "
        case courier = "Курьер: "
    }
    
    private enum EngTexts: String {
        case from = "From: "
        case to = "To: "
        case driver = "Driver: "
        case car = "Car: "
        case number = "Number: "
        case time = "Travel time : "
        case payment = "Payment № "
        case orderList = "Order list: "
        case store = "Store: "
        case courier = "Courier: "
    }
    
    
    static var from: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.from.rawValue
        case .eng:
            return EngTexts.from.rawValue
        }
    }
    
    static var to: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.to.rawValue
        case .eng:
            return EngTexts.to.rawValue
        }
    }
    static var driver: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.driver.rawValue
        case .eng:
            return EngTexts.driver.rawValue
        }
    }
    static var car: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.car.rawValue
        case .eng:
            return EngTexts.car.rawValue
        }
    }
    static var number: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.number.rawValue
        case .eng:
            return EngTexts.number.rawValue
        }
    }
    
    static var time: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.time.rawValue
        case .eng:
            return EngTexts.time.rawValue
        }
    }
    
    static var payment: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.payment.rawValue
        case .eng:
            return EngTexts.payment.rawValue
        }
    }
    
    static var orderList: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.orderList.rawValue
        case .eng:
            return EngTexts.orderList.rawValue
        }
    }
    
    static var store: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.store.rawValue
        case .eng:
            return EngTexts.store.rawValue
        }
    }
    
    static var courier: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.courier.rawValue
        case .eng:
            return EngTexts.courier.rawValue
        }
    }
    
}

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
    case OrderHistoryDetailView
    case OrderHistoryFoodDetailView
    case id = "OrderHistoryTableViewCell"
}

enum OrderHistoryDetailViewUIData: CGFloat {
    case width = 324
    case height = 345
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

enum SelectedIndex: Int {
    case null = 0
    case one = 1
    
    static func getSelectedIndex(from index: Int) -> Int {
        switch index {
        
        case 0:
            return 0
            
        case 1:
            return 1
    
        default:
            return 0
        }
    }
    
}

