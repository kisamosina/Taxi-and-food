//
//  LogoutViewUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 05.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum LogoutViewStringData: String {
    case nibName = "LogoutView"
}

enum LogoutViewSizes: CGFloat {
    case height = 270
    case mainViewCornerRadius = 15
}

struct LogoutViewTexts {
    
    private enum RusTexts: String {
        case logoutLabelText = "Выйти из приложения?"
        case cancelButtonTitle = "Отмена"
    }
    
    private enum EngTexts: String {
        case logoutLabelText = "Do you want to log out?"
        case cancelButtonTitle = "Cancel"
    }
    
    static var logoutLabelText: String {
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.logoutLabelText.rawValue
        case .eng:
            return EngTexts.logoutLabelText.rawValue
        }
    }
    
    static var cancelButtonTitle: String {
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.cancelButtonTitle.rawValue
        case .eng:
            return EngTexts.cancelButtonTitle.rawValue
        }
    }
}
