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
    case greyBorderColor
    case fontGrey
    case shadowColor
    case textBlack
    case tariffGreen
    case tariffPurple
    case tariffGold
    case closeButtonGrey
    case XTintColor
    case InactiveViewColor
    case mapMenuColor
    case redTextColor
    
    func getColor() -> UIColor {
        switch self {
        
        case .buttonBlue:
            return UIColor(hexString: "#3D3BFF")
        case .buttonGrey:
            return UIColor(hexString: "#D0D0D0")
        case .lightGrey:
            return UIColor(hexString: "#EFEFF0")
        case .greyBorderColor:
            return UIColor(hexString: "#CCCCCC")
        case .fontGrey:
            return UIColor(hexString: "#8A8A8D")
        case .shadowColor:
            return UIColor(hexString: "#000000", alpha: 0.1)
        case .textBlack:
            return UIColor(hexString: "#000000")
        case .tariffGreen:
            return UIColor(hexString: "#A0E14C")
        case .tariffPurple:
            return UIColor(hexString: "#C442F2")
        case .tariffGold:
            return UIColor(hexString: "#D4BD80")
        case .closeButtonGrey:
            return UIColor(hexString: "#E5E5E5")
        case .XTintColor:
            return UIColor(hexString: "#333333")
        case .InactiveViewColor:
            return UIColor(hexString: "#000000" , alpha: 0.5)
        case .mapMenuColor:
            return UIColor(hexString: "#FBFBFB")
        case .redTextColor:
            return UIColor(hexString: "#FF3B30")
        }
    }
}


enum CustomImagesNames: String {
    case CheckMark
    case X
    case payment
    case promocode
    case promocodeBackground
    case pomocodeActivated
    case promocodeExpire
    case promocodeExpired
}

enum StoryBoards: String {
    case AuthAndMap
    case Tarifs
    case Promocode
}

enum ViewControllers: String {
    case AuthViewController
    case UserAgreementViewController
    case ConfirmAuthViewController
    case MapViewController
    case TariffViewController
    case TariffsPageViewController
    case PromocodeViewController
    case PromocodeEnterViewController
    case PromocodeHistoryViewController
}


enum ViewsCornerRadiuses: CGFloat {
    case medium = 15
}

enum ImageNames: String {
    case plusWhite
}

enum BordersWidths: CGFloat {
    case standart = 1
}

enum NotificationsIdentifiers: String {
    case confirmtaionCode
}
