//
//  AddressEnterViewUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 16.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum AddressesViewNibsNames: String {
    case AddressTableViewCell
    case AddressEnterView
}

enum AddressEnterViewStringData: String {
    case addressTableViewCellReuseId = "AddressTableViewCell"
}

enum AddressesViewStringData: String {
    case AddressTableViewCell
}

enum AddressEnterViewSizes: CGFloat {
    case height = 260
    case tableViewHeight = 180
}

struct AddressesEnterViewTexts {
    
    private enum RusTexts: String {
        case toLabelPlaceHolder = "Куда вы хотите поехать?"
    }
    
    private enum EngTexts: String {
        case toLabelPlaceHolder = "Where do you want to go?"
    }
    
    static var toLabelPlaceHolderText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTexts.toLabelPlaceHolder.rawValue
        case .eng:
            return EngTexts.toLabelPlaceHolder.rawValue
        }
    }
}
