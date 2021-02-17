//
//  ServiceViewControllerUIData.swift
//  Taxi and food
//
//  Created by mac on 16/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct ServiceViewControllerTextData {
    
    internal enum RusTextViewPlaceholderText: String {
        case fillInPlaceholderTextRu = "Опишите возникшую проблему"
        
    }
    internal enum EngTextViewPlaceholderText: String {
        case fillInPlaceholderTextEn = "Describe your problem"
    }
    
    internal enum RusButtonText: String {
        case sendButtonTextRu = "Далее"
        
    }
    
    internal enum EngButtonText: String {
        case sendButtonTextEn = "Next"
        
    }
    
    static var fillInPlaceholderText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusTextViewPlaceholderText.fillInPlaceholderTextRu.rawValue
        case .eng:
            return EngTextViewPlaceholderText.fillInPlaceholderTextEn.rawValue
        }
    }
 
}
