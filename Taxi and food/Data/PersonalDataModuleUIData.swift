//
//  PersonalDataModuleUIData.swift
//  Taxi and food
//
//  Created by mac on 21/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct PersonalDataViewControllerText {
    
    internal enum RusNavigationItemTitleText: String {
        case navigationItemTextRu = "Персональные данные"
    }
    
    internal enum EngNavigationItemTitleText: String {
        case navigationItemTextEn = "Pesonal data"
    }
    
    internal enum RusNameTextFieldText: String {
        case nameTextFieldTextRu = "Как вас зовут?"
    }
    
    internal enum EngNameTextFieldText: String {
        case nameTextFieldTextEn = "What is your name?"
    }
    internal enum RusEmailTextFieldText: String {
        case emailTextFieldTextRu = "Укажите ваш e-mail"
    }
    
    internal enum EngEmailTextFieldText: String {
        case emailTextFieldTextEn = "Enter your e-mail"
    }
    
    internal enum RusPolicyLabelText: String {
        case policyLabelTextRu = "Указывая свои данные, вы подтверждаете, что ознакомились с пользовательским соглашением, а так же с политикой конфиденциальности"
    }
    
    internal enum EngPolicyLabelText: String {
        case policyLabelTextEn = "By entering your data, you confirm that you have read the user agreement, as well as the privacy policy"
    }
    
    internal enum RusTableHeaderText: String {
        case nameHeaderRu = "Имя"
        case emailHeaderRu = "E-mail"
    }
    
    internal enum EngTableHeaderText: String {
        case nameHeaderEn = "Name"
        case emailHeaderEn = "E-mail"
    }

    
    static var navigationItemTitleText: String {
    switch UserDefaults.standard.getAppLanguage() {
    case .rus:
        return RusNavigationItemTitleText.navigationItemTextRu.rawValue
    
    case .eng:
        return EngNavigationItemTitleText.navigationItemTextEn.rawValue
        }
    
    }
    
    static var nameTextFieldText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusNameTextFieldText.nameTextFieldTextRu.rawValue
        case .eng:
            return EngNameTextFieldText.nameTextFieldTextEn.rawValue
        }
    }
    
    static var emailTextFieldText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusEmailTextFieldText.emailTextFieldTextRu.rawValue
        case .eng:
            return EngEmailTextFieldText.emailTextFieldTextEn.rawValue
        }
    }
    
    static var policyLabelText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusPolicyLabelText.policyLabelTextRu.rawValue
        case .eng:
            return EngPolicyLabelText.policyLabelTextEn.rawValue
        }
    }
    static var nameHeaderText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusTableHeaderText.nameHeaderRu.rawValue
        case .eng:
            return EngTableHeaderText.nameHeaderEn.rawValue
        }
    }
    static var emailHeaderText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusTableHeaderText.emailHeaderRu.rawValue
        case .eng:
            return EngTableHeaderText.emailHeaderEn.rawValue
        }
    }
    
    
}
