//
//  TaxiOrderStatusViewTexts.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 21.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct TaxiOrderStatusViewTexts: TranslatableTexts {
    
    private enum RusTaxiOrderStatusViewTexts: String {
        case alreadyOnWay = "Уже в пути"
        case almostThere = "Почти на месте"
        case waitingForYou = "Вас ожидает"
        case waiting = "Ожидание"
        case freeWaitingDescription = "Время бесплатного ожидания согласно тарифу"
        case call = "Позвонить"
        case willBeSoon = "Скоро буду"
    }
    
    private enum EngTaxiOrderStatusViewTexts: String {
        case alreadyOnWay = "Already on way"
        case almostThere = "Almost there"
        case waitingForYou = "Waiting for you"
        case waiting = "Waiting"
        case freeWaitingDescription = "Free waiting time according to the tariff"
        case call = "Call"
        case willBeSoon = "I will be soon"
    }
    
    static var alreadyOnWay: String {
            
        switch lang {
        
        case .rus:
            return RusTaxiOrderStatusViewTexts.alreadyOnWay.rawValue
        case .eng:
            return EngTaxiOrderStatusViewTexts.alreadyOnWay.rawValue
        }
    }
    
    static var almostThere: String {
        
        switch lang {
        
        case .rus:
            return RusTaxiOrderStatusViewTexts.almostThere.rawValue
        case .eng:
            return EngTaxiOrderStatusViewTexts.almostThere.rawValue
        }
    }
    
    static var waitingForYou: String {
        
        switch lang {
        
        case .rus:
            return RusTaxiOrderStatusViewTexts.waitingForYou.rawValue
        case .eng:
            return EngTaxiOrderStatusViewTexts.waitingForYou.rawValue
        }
    }
    
    static var waiting: String {
        
        switch lang {
            
        case .rus:
            return RusTaxiOrderStatusViewTexts.waiting.rawValue
        case .eng:
            return EngTaxiOrderStatusViewTexts.waiting.rawValue
        }
    }
    
    static var freeWaitingDescription: String {
        
        switch lang {
        
        case .rus:
            return RusTaxiOrderStatusViewTexts.freeWaitingDescription.rawValue
        case .eng:
            return EngTaxiOrderStatusViewTexts.freeWaitingDescription.rawValue
        }
    }
    
    static var call: String {
        
        switch lang {
        
        case .rus:
            return RusTaxiOrderStatusViewTexts.call.rawValue
        case .eng:
            return EngTaxiOrderStatusViewTexts.call.rawValue
        }
    }

    static var willBeSoon: String {
        
        switch lang {
            
        case .rus:
            return RusTaxiOrderStatusViewTexts.willBeSoon.rawValue
        case .eng:
            return EngTaxiOrderStatusViewTexts.willBeSoon.rawValue
        }
    }
}


struct TaxiOrderStatusTableViewCellModelTexts: TranslatableTexts {
    
    private enum RusTexts: String {
        case changeAddressTrip = "Изменить адрес поездки"
        case specifyArrivalPlace = "Уточнить место приезда"
        case cancelOrder = "Отменить заказ"
    }
    
    private enum EngTexts: String {
        case changeAddressTrip = "Change trip address"
        case specifyArrivalPlace = "Spicify arrival place"
        case cancelOrder = "Cancel the order"
    }
    
    static var changeAddressTrip: String {
        switch lang {
            
        case .rus:
            return RusTexts.changeAddressTrip.rawValue
        case .eng:
            return EngTexts.changeAddressTrip.rawValue
        }
    }
    
    static var specifyArrivalPlace: String {
        switch lang {
            
        case .rus:
            return RusTexts.specifyArrivalPlace.rawValue
        case .eng:
            return EngTexts.specifyArrivalPlace.rawValue
        }
    }
    
    static var cancelOrder: String {
        switch lang {
            
        case .rus:
            return RusTexts.cancelOrder.rawValue
        case .eng:
            return EngTexts.cancelOrder.rawValue
        }
    }
    
}
