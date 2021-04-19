//
//  PromocodeActivatedUiData.swift
//  Taxi and food
//
//  Created by mac on 15/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum PromocodeActivatedViewStringData: String {
    case nibName = "PromocodeActivatedView"
}

enum PromocodeActivatedViewSize: CGFloat {
    case height = 270
}

struct PromocodeActivatedTexts {
    
    private enum RusTexts: String {
       case title = "Промокод активирован"
    
    }
    
    private enum EngTexts: String {
       case title = "Promocode has need activated"
    
    }
    
    static var titleText: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusTexts.title.rawValue
        case .eng:
            return EngTexts.title.rawValue
        }
    }
}
