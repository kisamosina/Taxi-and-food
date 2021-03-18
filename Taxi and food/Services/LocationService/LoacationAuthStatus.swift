//
//  LoacationAuthStatus.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 16.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

enum LocationAuthStatus {
    case notDetermined
    case denied
    case granted
    
    var status: String {
        
        switch self {
                                
        case .notDetermined:
            
            switch UserDefaults.standard.getAppLanguage() {
            
            case .rus:
                return "Не получается определить ваше местоположение!"
            case .eng:
                return "Can't update your location!"
            }
            
        case .denied:
            
            switch UserDefaults.standard.getAppLanguage() {
            
            case .rus:
                return "Приложение не знает где вы находитесь. Дайте приложению доступ для определения вашего местоположения в настройках устройства!"
            case .eng:
                return "The application does not know where you are. Give access to the application for detect your location in device settings!"
            }
            
            case .granted:
            
                switch UserDefaults.standard.getAppLanguage() {
                
                case .rus:
                    return "Все хорошо! Определяем ваше местоположение..."
                case .eng:
                    return "There is everything good! Detecting your location..."
                }
        }
    }
}
