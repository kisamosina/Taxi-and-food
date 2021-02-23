//
//  MainBottomButtonUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 19.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum MainButtonTypes {
    case next
    case send
    case taxiOrder
    case approve
}



struct MainButtonTitles {
    
    internal enum RusButtonsTitles: String {
        case nextButtonTitle = "Далее"
        case sendButtonTitle = "Отправить"
        case orderTaxiTitle = "Заказать такси"
        case approveButtonTitle = "Подтвердить"
    }
    
    internal enum EngButtonsTitles: String {
        case nextButtonTitle = "Next"
        case sendButtonTitle = "Send"
        case orderTaxiTitle = "Order taxi"
        case approveButtonTitle = "Подтвердить"
    }
    
    static var nextButtonTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.nextButtonTitle.rawValue
        case .eng:
            return EngButtonsTitles.nextButtonTitle.rawValue
        }
    }
    
    static var sendButtonTitle: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.sendButtonTitle.rawValue
        case .eng:
            return EngButtonsTitles.sendButtonTitle.rawValue
        }

    }
    
    static var orderTaxiButtonTitle: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.orderTaxiTitle.rawValue
        case .eng:
            return EngButtonsTitles.orderTaxiTitle.rawValue
        }

    }
    
    static var approveTitle: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.approveButtonTitle.rawValue
        case .eng:
            return EngButtonsTitles.approveButtonTitle.rawValue
        }
    }
    
    static func getTitle(for type: MainButtonTypes) -> String {
        
        switch type {
        
        case .next:
            return nextButtonTitle
        case .send:
            return sendButtonTitle
        case .taxiOrder:
            return orderTaxiButtonTitle
        case .approve:
            return approveTitle
        }
    }
}

enum MainButtonSizes: CGFloat {
    case height = 50
}
