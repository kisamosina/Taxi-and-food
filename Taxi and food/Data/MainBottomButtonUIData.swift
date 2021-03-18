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
    case perfect
    case sendEmail
    case logOut
    case linkACard
    case newOrder
    case beginSavePoints
}



struct MainButtonTitles {
    
    internal enum RusButtonsTitles: String {
        case nextButtonTitle = "Далее"
        case sendButtonTitle = "Отправить"
        case orderTaxiTitle = "Заказать такси"
        case approveButtonTitle = "Подтвердить"
        case perfectButtonTitle = "Отлично!"
        case sendEmail = "Отправить e-mail"
        case logOut = "Выйти"
        case linkACard = "Привязать карту"
        case newOrder = "Новый заказ"
        case beginSavePoints = "Начать копить баллы"
    }
    
    internal enum EngButtonsTitles: String {
        case nextButtonTitle = "Next"
        case sendButtonTitle = "Send"
        case orderTaxiTitle = "Order taxi"
        case approveButtonTitle = "Approve"
        case perfectButtonTitle = "Perfect!"
        case sendEmail = "Send e-mail"
        case logOut = "Log Out"
        case linkACard = "Link a card"
        case newOrder = "New order"
        case beginSavePoints = "Begin saving points"
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
    
    static var perfectButtonTitle: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.perfectButtonTitle.rawValue
        case .eng:
            return EngButtonsTitles.perfectButtonTitle.rawValue
        }
    }
    
    static var sendEmail: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.sendEmail.rawValue
        case .eng:
            return EngButtonsTitles.sendEmail.rawValue
        }

    }
    
    static var logOut: String {
       
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.logOut.rawValue
        case .eng:
            return EngButtonsTitles.logOut.rawValue
        }

    }
    
    static var linkACard: String {
       
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.linkACard.rawValue
        case .eng:
            return EngButtonsTitles.linkACard.rawValue
        }
        
    }
    
    static var newOrderTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.newOrder.rawValue
        case .eng:
            return EngButtonsTitles.newOrder.rawValue
        }
    }

    static var beginSavingPointsTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.beginSavePoints.rawValue
        case .eng:
            return EngButtonsTitles.beginSavePoints.rawValue
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
        case .perfect:
            return perfectButtonTitle
        case .sendEmail:
            return sendEmail
        case .logOut:
            return logOut
        case .linkACard:
            return linkACard
        case .newOrder:
            return newOrderTitle
        case .beginSavePoints:
            return beginSavingPointsTitle
        }
    }
}

enum MainButtonSizes: CGFloat {
    case height = 50
}
