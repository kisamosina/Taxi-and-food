//
//  GeneralUISettings.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 14.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

var screenHieght: CGFloat { UIScreen.main.bounds.height }
var screenWidth: CGFloat { UIScreen.main.bounds.width }

enum AppLanguages: String {
    case rus
    case eng
    
    static func getLanguage(_ language: String) -> AppLanguages {
        switch language {
        case "rus": return .rus
        default: return .eng
        }
    }
    
    func getLocaleID() -> String {
        
        switch self {
        
        case .rus:
            return "ru_RU"
        case .eng:
            return "en"
        }
    }
}

enum AppSettingsStorageKeys: String {
    case language
    case pointsIsFirstTimeUsage
    case tipAddressViewShowing
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
    case logOutButtonBorderColor
    case bouncesPointsTextColor
    case taxiOrange
    case whiteTransparent
    case backGroundGreyActive
    case textColorGreen
    case dullGrey
    
    
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
        case .logOutButtonBorderColor:
            return UIColor(hexString: "#C6C6C8")
        case .bouncesPointsTextColor:
            return UIColor(hexString: "#FACA50")
        case .taxiOrange:
            return UIColor(hexString: "FB8E50")
        case .whiteTransparent:
            return UIColor(hexString: "#FFFFFF", alpha: 0.5)
        case .backGroundGreyActive:
            return UIColor(hexString: "#F0F0F0")
        case .textColorGreen:
            return UIColor(hexString: "#34C759")
        case .dullGrey:
            return UIColor(hexString: "#F3F3F3")
        }
    }
}

enum UILabelStyles {
    case boldOrange(CGFloat = 17)
    case lightGrey(CGFloat = 17)
    case systemDefault
    case normalGrey(CGFloat = 17)
    case headerSemiBold(CGFloat = 26)
    case normalBlack(CGFloat)
    case normal(CGFloat)
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
    case paymentHistoryBackground
    case visaIcon
    case mastercardIcon
    case saw
    case paBackground
    case lkBlue
    case paymentWayMainScreenBackGroundImage
    case paymentWayActiveCellCheckmark
    case paymentWayEnterCellCheckmark
    case paymentWayInActiveCellCheckmark
    case paymentWayApple
    case paymentWayCash
    case paymentWayOne
    case paymentWayPoints
    case userPinGrey
    case clockGrey
    case userPin
    case paymentPoints
    case menuButton
    case backButton
    case userPinOrange
    case iconTariffBusiness = "icon_tariff_business"
    case iconTariffPremium = "icon_tariff_premium"
    case iconTariffStandart = "icon_tariff_standart"
    case iconPromocodeActivated = "icon_promocode_activated"
    case iconEmmitterSecionFirst = "icon_emmiter_section_first"
    case iconEmmitterSecionSecond = "icon_emmiter_section_second"
    case iconEmmitterSecionThird = "icon_emmiter_section_third"
    case iconCancelFace = "icon_cancel_face"
    case iconFlagRu = "icon_flag_ru"
    case iconRing = "icon_ring"
    case iconOrderCancelation = "icon_order_cancelation"
    
}

enum StoryBoards: String {
    case AuthAndMap
    case Tarifs
    case Settings
    case Addresses
    case Promocode
    case Service
    case PaymentHistory
    case PersonalAccount
    case Inactive
    case PaymentWay
    case PersonalData
    case Promo
    
}

enum ViewControllers: String {
    case AuthViewController
    case UserAgreementViewController
    case ConfirmAuthViewController
    case MapViewController
    case TariffViewController
    case TariffsPageViewController
    case SettingsViewController
    case AppleMapViewController
    case AllAddressesViewController
    case AddressViewController
    case PromocodeViewController
    case PromocodeEnterViewController
    case PromocodeHistoryViewController
    case SentViewController
    case PaymentHistoryViewController
    case InactiveViewController
    case PersonalAccountViewController
    case PaymentWayViewController
    case ServiceViewController
    case NewCardEnterViewController
    case ShowLoactionViewController
    case LanguageViewController
    case PersonalDataViewController
    case PromoViewController
    
}


enum ViewsCornerRadiuses: CGFloat {
    case small = 10
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


