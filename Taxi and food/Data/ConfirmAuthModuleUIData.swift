//
//  ConfirmAuthModuleUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 15.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

enum ConfirmAuthVCLabelsTexts: String {
    case topLabelRus = "Код подтверждения"
    case topLabelEn = "Approval code"
    case resendTextRus = "Повторить отправку."
    case resendTextEn = "Resend code."
    }

struct ConfirmAuthViewControllerTexts{
    
    internal enum RusLabelTexts: String {
        case topLabelText = "Код подтверждения"
        case descriptionLabelText = "На номер$отправлено СМС с кодом.$Повторная отправка будет доступна через"
        case resendText = "Повторить отправку."
    }
    
    internal enum EngLabelTexts: String {
        case topLabelText = "Approval code"
        case descriptionLabelText = "On number $sended SMS with code. $Resend will be available after $seconds."
        case resendText = "Resend code."
    }
    
    static var topLabelText: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusLabelTexts.topLabelText.rawValue
        case .eng:
            return EngLabelTexts.topLabelText.rawValue
        }
    }

    static var descriptionLabelText: String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusLabelTexts.descriptionLabelText.rawValue
        case .eng:
            return EngLabelTexts.descriptionLabelText.rawValue
        }
    }
    
    static var resendText: String {
            switch UserDefaults.standard.getAppLanguage() {
            
            case .rus:
                return RusLabelTexts.resendText.rawValue
            case .eng:
                return EngLabelTexts.resendText.rawValue
            }
        }
    
    static func ruSeconds(_ seconds: Int) -> String {
        
        switch seconds {
        
        case 1, 21:
            return "секунду"
        case 2, 3, 4, 22, 23, 24:
            return "секунды"
        default:
            return "секунд"
        }
    }
    
    static func attributedText(for seconds: Int) -> String {
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            
            if seconds == 0 {
                return self.resendText
            } else {
                return "\(seconds) \(self.ruSeconds(seconds))."
            }
        case .eng:
            if seconds == 0 {
                return self.resendText
            } else {
                return "\(seconds) seconds."
            }
        }
    }
}
