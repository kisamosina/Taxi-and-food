//
//  ShopsViewUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 31.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum ShopsViewNibsNames: String {
    case ShopsView
    case ShopsCollectionViewCell
}

enum ShopsViewStringData: String {
    case cellReuseId = "ShopsViewCollectionViewCell"
}

enum ShopsViewUIData: CGFloat {
    case shadowOffsetWidth = 0
    case shadowOffsetHeight = 1.01
    case shadowOpacity = 1
    case shadowRadius = 10
    case viewHeight = 405
    case summCollectionViewInsets = 60
    case cellHeight = 80
}
