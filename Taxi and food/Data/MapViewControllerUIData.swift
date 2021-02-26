//
//  MapViewsUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 19.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum MapRoundButtonUIData: CGFloat {
    case shadowOpacity = 1
    case shadowRadius = 10
    case shadowOffsetHeight = 1.01
    case shadowOffsetWidth = 0
}

enum MapBottomViewUIData: CGFloat {
    case shadowOpacity = 1
    case cornerRadius = 20
    case shadowOffsetHeight = 2
    case shadowOffsetWidth = 2.01
}

enum MapViewControllerConstraintsData: CGFloat {
    case maximizedTrailingMenuViewConstant = 42
}

enum MapMenuViewUIData: CGFloat {
    case shadowOpacity = 1
    case cornerRadius = 20
    case shadowOffsetHeight = 2
    case shadowOffsetWidth = 2.01
}

enum MapInactiveViewAlpha: CGFloat {
    case active = 1
    case inactive = 0
}

struct MapMenuViewTexts {
    
    internal enum RusTexts: String {
        case Menu = "Меню"
        case About = "Об этом приложении (v.1)"
    }
    
    internal enum EngTexts: String {
        case Menu
        case About = "About this application (v.1)"
    }
    
    static var menuLabelText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTexts.Menu.rawValue
        case .eng:
            return RusTexts.Menu.rawValue
        }
    }
    
    static var aboutLabelText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTexts.About.rawValue
        case .eng:
            return RusTexts.About.rawValue
        }
    }

    
    static var menuTableViewCellId: String {
        return "MapMenuViewCell"
    }
}

enum MapViewControllerSegue {
    case Tariffs
    case Promocode
    case unknown
    
    static func getMapViewControllerSegue(_ cellTitle: String) -> MapViewControllerSegue {
        switch cellTitle {
        case MapMenuData.tariffs:
            return Tariffs
        case MapMenuData.promocodes:
            return Promocode
        default:
            return .unknown
        }
    }
}
