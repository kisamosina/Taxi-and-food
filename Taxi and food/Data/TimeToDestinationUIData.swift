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

struct TimeToDestinationViewTexts {
    
    static var labelTitle: String {
        switch UserDefaults.standard.getAppLanguage() {
        case .rus:
            return "мин"
        case .eng:
            return "min"
        }
    }
}
