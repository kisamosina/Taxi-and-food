//
//  MainBottomButtonUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 19.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

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
}



struct MainButtonTitles {
    
    internal enum RusButtonsTitles: String {
        case nextButtonTitle = "Далее"
        case sendButtonTitle = "Отправить"
        case orderTaxiTitle = "Заказать такси"
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
    
    static func getTitle(for type: MainButtonTypes) -> String {
        
        switch type {
        
        case .next:
            return nextButtonTitle
        case .send:
            return sendButtonTitle
        case .taxiOrder:
            return orderTaxiButtonTitle
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
