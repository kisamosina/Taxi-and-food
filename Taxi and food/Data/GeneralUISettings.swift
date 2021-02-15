//
//  GeneralUISettings.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 14.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum AppLanguages: String {
    case rus
    case eng
    
    static func getLanguage(_ language: String) -> AppLanguages {
        switch language {
        case "rus": return .rus
        default: return .eng
        }
    }
}

enum AppSettingsStorageKeys: String {
    case language
}

enum Colors {
    case buttonBlue
    case buttonGrey
    case lightGrey
    
    func getColor() -> UIColor {
        switch self {
        
        case .buttonBlue:
            return UIColor(hexString: "#3D3BFF")
        case .buttonGrey:
            return UIColor(hexString: "#D0D0D0")
        case .lightGrey:
            return UIColor(hexString: "EFEFF0")
        }
    }
}


enum CustomImagesNames: String {
    case CheckMark
}

enum StoryBoards: String {
    case AuthAndMap
}

enum ViewControllers: String {
    case AuthViewController
    case UserAgreementViewController
    case ConfirmAuthViewController
    case MapViewController
}

struct CustomButtonsTitles {
    
    internal enum RusCustomButtonsTitles: String {
        case nextButtonTitle = "Далее"
    }
    
    internal enum EngCustomButtonsTitles: String {
        case nextButtonTitle = "Next"
    }
    
    static var nextButtonTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusCustomButtonsTitles.nextButtonTitle.rawValue
        case .eng:
            return EngCustomButtonsTitles.nextButtonTitle.rawValue
        }
    }

}
