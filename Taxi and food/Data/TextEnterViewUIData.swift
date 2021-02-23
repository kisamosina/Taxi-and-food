//
//  TextEnterViewUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 23.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum TextEnterViewUpperViewData: CGFloat {
    case width = 40
    case height = 5
}

enum TextEnterViewStackViewData: CGFloat  {
    case mainStackSpacing = 10
    case innerStackSpacing = 8
}

enum TextEnterViewSize: CGFloat {
    case height = 167
}

enum TextEnterViewConstraints: CGFloat {
    case upViewHeight = 5
    case upViewWidth = 40
    case mainViewHeight = 152
    case innerStackViewTopAnchor = 22
    case innerViewLeadingAnchor = 25
    case innerViewTrailingAndBottomAnchor = -25
}

enum TextEnterViewFontSizes: CGFloat {
    case labelFontSize = 10
}
