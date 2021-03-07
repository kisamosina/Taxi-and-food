//
//  AddressModuleUIData.swift
//  Taxi and food
//
//  Created by mac on 05/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct AddressViewControllerText {
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
    
    
}


