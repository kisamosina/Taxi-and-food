//
//  TaxiOrderViewUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 27.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import UIKit

enum TaxiOrderViewStringData: String {
    case nibFileName = "TaxiOrderView"
    case tariffsCollectionViewCellReuseId = "TaxiOrderCollectionViewCell"
}

enum TaxiOrderViewSizesData: CGFloat {
    case viewHeight = 470
    case tariffCellShadowOpacity = 1
    case tariffCellShadowRadius = 15
    case tariffCellShadowOffsetWidth = 1.01
    case tariffCellShadowOffsetHeight = 1.02
    case collectionViewSumOffsets = 64
    case tariffCellHeight = 80
}

