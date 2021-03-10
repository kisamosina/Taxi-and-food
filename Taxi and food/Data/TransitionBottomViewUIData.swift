//
//  TransitionBottomViewUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 09.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum TransitionBottomViewTypes {
    case cardApproveMent
}

enum TransitionBottomViewSizes: CGFloat {
    case shadowOpacity = 1
    case cornerRadius = 20
    case shadowOffsetHeight = 2
    case shadowOffsetWidth = 2.01
    case descriptionLabelFontSize = 12
}

enum TransitionBottomViewStringData: String {
    case nibName = "TransitionBottomView"
}
