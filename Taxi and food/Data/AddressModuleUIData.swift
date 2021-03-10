//
//  AddressModuleUIData.swift
//  Taxi and food
//
//  Created by mac on 05/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation


    
    struct TextFieldsPlaceholderText {
        enum RusText: String {
            
            case addressNameTextField = "Название адреса"
            case addressTextField = "Адрес"
            case commentForDriverTextField = "Комментарий для водителя"
            case officeTextField = "Кв./офис"
            case entranceTextField = "Подъезд"
            case intercomTextField = "Домофон"
            case floorTextField = "Этаж"
            case commenForCourierTextField = "Комментарий для курьера"
            
        }

        enum EngText: String {
            
            case addressNameTextField = "Address name"
            case addressTextField = "Address"
            case commentForDriverTextField = "Comment for the driver"
            case officeTextField = "APT/OFC"
            case entranceTextField = "Entrance"
            case intercomTextField = "Intercom"
            case floorTextField = "Floor"
            case commenForCourierTextField = "Comment for the courier"
            
        }
        
        
        
        static var nameAddressText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusText.addressNameTextField.rawValue

        case .eng:
            return EngText.addressNameTextField.rawValue
            }
            
        }
        
        static var addressText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusText.addressTextField.rawValue

        case .eng:
            return EngText.addressTextField.rawValue
            }
            
        }
        
        static var commentForDriverText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusText.commentForDriverTextField.rawValue

        case .eng:
            return EngText.commentForDriverTextField.rawValue
            }
            
        }
        static var officeText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusText.officeTextField.rawValue

        case .eng:
            return EngText.officeTextField.rawValue
            }
            
        }
        static var entranceText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusText.entranceTextField.rawValue

        case .eng:
            return EngText.entranceTextField.rawValue
            }
            
        }
        static var intercomText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusText.intercomTextField.rawValue

        case .eng:
            return EngText.intercomTextField.rawValue
            }
            
        }
        static var floorText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusText.floorTextField.rawValue

        case .eng:
            return EngText.floorTextField.rawValue
            }
            
        }
        static var commenForCourierText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusText.commenForCourierTextField.rawValue

        case .eng:
            return EngText.commenForCourierTextField.rawValue
            }
            
        }
  
    }

struct AddressViewControllerText {
    
    internal enum RusMapButtonTitleText: String {
        case mapButtonTextRu = "Карта"
        
    }
    internal enum EngMapButtonTitleText: String {
        case mapButtonTextEn = "Map"
        
    }
    
    internal enum RusDeliveryLabelText: String {
        case deliveryLabelTextRu = "Для доставки"
        
    }
    internal enum EngDeliveryLabelText: String {
        case deliveryLabelTextEn = "For delivery"
        
    }
    
    
    internal enum RusNavigationItemTitleText: String {
        case navigationItemTextRu = "Мои адреса"
        
    }
    internal enum EngNavigationItemTitleText: String {
        case navigationItemTextEn = "My addresses"
        
    }
    
    internal enum RusNavigationItemNewTitleText: String {
        case navigationItemNewTextRu = "Новый адрес"
        
    }
    internal enum EngNavigationItemNewTitleText: String {
        case navigationItemNewTextEn = "New address"
        
    }
    
    internal enum RusNavigationItemHomeTitleText: String {
        case navigationItemHomeTextRu = "Дом"
        
    }
    internal enum EngNavigationItemHomeTitleText: String {
        case navigationItemHomeTextEn = "Home"
        
    }
    
    internal enum RusIsEmptyHereLabelText: String {
        case isEmptyHereLabelTextRu = "Здесь пока пусто..."
        
    }
    internal enum EngIsEmptyHereLabelText: String {
        case isEmptyHereLabelTextEn = "It's empty here for now ..."
        
    }
    
    static var deliveryLabelText: String {
    switch UserDefaults.standard.getAppLanguage() {
    case .rus:
        return RusDeliveryLabelText.deliveryLabelTextRu.rawValue

    case .eng:
        return EngDeliveryLabelText.deliveryLabelTextEn.rawValue
        }
        
    }
    
    
    static var navigationItemTitleText: String {
    switch UserDefaults.standard.getAppLanguage() {
    case .rus:
        return RusNavigationItemTitleText.navigationItemTextRu.rawValue

    case .eng:
        return EngNavigationItemTitleText.navigationItemTextEn.rawValue
        }
        
    }
    
    static var navigationItemNewTitleText: String {
    switch UserDefaults.standard.getAppLanguage() {
    case .rus:
        return RusNavigationItemNewTitleText.navigationItemNewTextRu.rawValue

    case .eng:
        return EngNavigationItemNewTitleText.navigationItemNewTextEn.rawValue
        }
        
    }
    
    static var navigationItemHomeTitleText: String {
    switch UserDefaults.standard.getAppLanguage() {
    case .rus:
        return RusNavigationItemHomeTitleText.navigationItemHomeTextRu.rawValue

    case .eng:
        return EngNavigationItemHomeTitleText.navigationItemHomeTextEn.rawValue
        }
        
    }
    
    static var isEmptyHereLabelText: String {
    switch UserDefaults.standard.getAppLanguage() {
    case .rus:
        return RusIsEmptyHereLabelText.isEmptyHereLabelTextRu.rawValue

    case .eng:
        return EngIsEmptyHereLabelText.isEmptyHereLabelTextEn.rawValue
        }
        
    }
    
    static var mapButtonTitleText: String {
    switch UserDefaults.standard.getAppLanguage() {
    case .rus:
        return RusMapButtonTitleText.mapButtonTextRu.rawValue

    case .eng:
        return EngMapButtonTitleText.mapButtonTextEn.rawValue
        }
        
    }
    
    
}


