//
//  PersonalDataBottomViewUIData.swift
//  Taxi and food
//
//  Created by mac on 24/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

enum PersonalDataBottomViewStringData: String {
    case nibName = "PersonalDataBottomView"
}

struct PersonalDataBottomViewTexts {

static var enterNamePlaceholderTitle: String {
    
    switch UserDefaults.standard.getAppLanguage() {
        
    case .rus:
        return "Как вас зовут?"
    case .eng:
        return "What is your name?"
    }
    
    }
    
    static var enterEmailPlaceholderTitle: String {
    
    switch UserDefaults.standard.getAppLanguage() {
        
    case .rus:
        return "Укажите ваш e-mail"
    case .eng:
        return "Enter your e-mail"
    }
        
    }
    
    
}

