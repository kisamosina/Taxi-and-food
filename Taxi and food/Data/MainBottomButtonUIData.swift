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
    case goBuy
    case addAddress
    case save
    case chooseDestination
    case delete
    case cancel
    case approve
    case perfect
    case sendEmail
    case logOut
    case linkACard
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
        case goBuyTitle = "За покупками!"
        case addAddressTitle = "Добавить адресс"
        case saveTitle = "Сохранить"
        case chooseDestinationTitle = "Выбрать местом назначения"
        case deleteTitle = "Удалить"
        case cancelTitle = "Отмена"
    }
    
    internal enum EngButtonsTitles: String {
        case nextButtonTitle = "Next"
        case sendButtonTitle = "Send"
        case orderTaxiTitle = "Order taxi"
        case goBuyTitle = "Go shopping!"
        case addAddressTitle = "Add address"
        case saveTitle = "Save"
        case chooseDestinationTitle = "Choose destination"
        case deleteTitle = "Delete"
        case cancelTitle = "Cancel"
        case approveButtonTitle = "Approve"
        case perfectButtonTitle = "Perfect!"
        case sendEmail = "Send e-mail"
        case logOut = "Log Out"
        case linkACard = "Link a card"
    }
    
    static var cancelButtonTitle: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.cancelTitle.rawValue
        case .eng:
            return EngButtonsTitles.cancelTitle.rawValue
        }

    }
    
    static var deleteButtonTitle: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.deleteTitle.rawValue
        case .eng:
            return EngButtonsTitles.deleteTitle.rawValue
        }

    }
    
    static var chooseDestinationButtonTitle: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.chooseDestinationTitle.rawValue
        case .eng:
            return EngButtonsTitles.chooseDestinationTitle.rawValue
        }

    }
    
    static var saveButtonTitle: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.saveTitle.rawValue
        case .eng:
            return EngButtonsTitles.saveTitle.rawValue
        }

    }
    
    static var addAddresButtonTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.addAddressTitle.rawValue
        case .eng:
            return EngButtonsTitles.addAddressTitle.rawValue
        }
    }
    
    static var goBuyButtonTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusButtonsTitles.goBuyTitle.rawValue
        case .eng:
            return EngButtonsTitles.goBuyTitle.rawValue
        }
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
        case .goBuy:
            return goBuyButtonTitle
        case .addAddress:
            return addAddresButtonTitle
        case .save:
            return saveButtonTitle
        case .chooseDestination:
            return chooseDestinationButtonTitle
        case .delete:
            return deleteButtonTitle
        case .cancel:
            return cancelButtonTitle
        }
    }
}

enum MainButtonSizes: CGFloat {
    case height = 50
}
