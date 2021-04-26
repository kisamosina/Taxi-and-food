//
//  TimeToDestinationUIData.swift
//  Taxi and food
//
//  Created by mac on 07/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum TimeToDestinationViewStringData: String {
    case nibName = "TimeToDestinationView"
}

enum TimeToDestinationViewSizes: CGFloat {
    case height = 40
    case width = 125
    case cornerRadius = 15
}

struct TimeToDestinationViewTexts {
    
    static var labelTitle: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return "≈15 мин"
        case .eng:
            return "≈15 min"
        }
    }
}
