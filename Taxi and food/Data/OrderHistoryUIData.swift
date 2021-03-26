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
        
    }
    
     private enum EngTexts: String {
        case emptyLabelText = "It's empty here for now..."
        case typeFood = "Food"
        case typeTaxi = "Taxi"
        case rub = " руб."
        case firstSegmentTitle = "Completed"
        case secondSegmentTitle = "Canceled"
        case title = "Order history"
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
    
}

enum OrderHistoryIds: String {
    case id = "OrderHistoryTableViewCell"
}
