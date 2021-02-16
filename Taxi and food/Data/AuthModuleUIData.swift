//
//  AuthModuleUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 15.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

enum AuthVCLabelsTexts: String {
    
    case topLabelTextRus = "Укажите номер телефона"
    case topLabelTextEn =  "Set telephone number"
    case bottomLabelTextRus = "Даю согласие на обработку персональных данных, с пользовательским соглашением ознакомлен"
    case bottomLabelTextEn = "I agree to the personal data processing, I have read the user agreement"
    case userAgreementTextRus = "пользовательским соглашением"
    case userAgreementTextEn = "user agreement"
}

enum AuthVCButtonsTexts: String {
    case nextButtonTitleRus = "Далее"
    case nextButtonTitleEn = "Next"
}

struct AuthViewControllerTextData {
    
    //AuthViewController labels rus text
    internal enum RusLabelTexts: String {
        case topLabelText = "Укажите номер телефона"
        case bottomLabelText = "Даю согласие на обработку персональных данных, с пользовательским соглашением ознакомлен"
        case userAgreementText = "пользовательским соглашением"
    }
    
    //AuthViewController labels english text
    internal enum EngLabelTexts: String {
        case topLabelText =  "Set telephone number"
        case bottomLabelText = "I agree to the personal data processing, I have read the user agreement"
        case userAgreementText = "user agreement"
    }
    
    static var topLabelText: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusLabelTexts.topLabelText.rawValue
        case .eng:
            return EngLabelTexts.topLabelText.rawValue
        }
    }
    
    static var bottomLabelText: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusLabelTexts.bottomLabelText.rawValue
        case .eng:
            return EngLabelTexts.bottomLabelText.rawValue
        }
    }
    
    static var userAgreementText: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusLabelTexts.userAgreementText.rawValue
        case .eng:
            return EngLabelTexts.userAgreementText.rawValue
        }
    }
    
}
