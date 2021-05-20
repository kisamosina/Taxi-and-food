//
//  DriverNotFoundViewTexts.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct DriverNotFoundViewTexts: TranslatableTexts {
    
    private enum DriverNotFoundViewTextsRus: String {
        case driverIsNotNearby = "Водителей поблизости пока нет"
        case isNotNearbyDescription = "К сожалению, в радиусе 30 км не нашлось водителей. Вы можете продолжить поиск в фоновом режиме."
        case weWillSendPush = "Как только появится подходящий вариант, мы отправим вам push-уведомление"
    }
    
    private enum DriverNotFoundViewTextsEng: String {
        case driverIsNotNearby = "There are no drivers nearby"
        case isNotNearbyDescription = "Unfortunately, there were no drivers within a radius of 30 km. You can continue searching in the background."
        case weWillSendPush = "As soon as the appropriate option appears, we will send you a push-notice"
    }
    
    static var driverIsNotNearby: String {
        switch lang {
            
        case .rus:
            return DriverNotFoundViewTextsRus.driverIsNotNearby.rawValue
        case .eng:
            return DriverNotFoundViewTextsEng.driverIsNotNearby.rawValue
        }
    }
    
    static var isNotNearbyDescription: String {
        switch lang {
            
        case .rus:
            return DriverNotFoundViewTextsRus.isNotNearbyDescription.rawValue
        case .eng:
            return DriverNotFoundViewTextsEng.isNotNearbyDescription.rawValue
        }
    }
    
    static var weWillSendYouPush: String {
        switch lang {
            
        case .rus:
            return DriverNotFoundViewTextsRus.weWillSendPush.rawValue
        case .eng:
            return DriverNotFoundViewTextsEng.weWillSendPush.rawValue
        }
    }
}
