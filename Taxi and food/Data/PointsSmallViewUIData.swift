//
//  PointsSmallViewUIData.swift
//  Taxi and food
//
//  Created by mac on 16/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum PointsSmallViewStringData: String {
    case nibName = "PointsSmallView"
}

enum PointsSmallViewSize: CGFloat {
    case height = 220
}

struct PointsSmallViewTexts {
    
    private enum RusTexts: String {
        case otherAmount = "Другое количество"
        
    
    }
    
    private enum EngTexts: String {
        case otherAmount = "Oher amount"
        
        
    
    }
    
    static var otherAmountButtonTitle: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return RusTexts.otherAmount.rawValue
        case .eng:
            return EngTexts.otherAmount.rawValue
        }
    }
    
    
}
