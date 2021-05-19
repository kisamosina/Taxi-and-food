//
//  CancelationOrderViewSizes.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 19.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import UIKit

struct CancelationOrderViewSizes {
    private static let topPadding: CGFloat = 41 + 22
    private static let cancelationReasonLableHeight: CGFloat = 17
    private static let topTableViewPadding: CGFloat = 30 + 20
    private static let bottomTableViewPadding: CGFloat = 51 + 22
    private static var tableViewHeight: CGFloat {
        CGFloat(CancelationOrderViewTexts.cancelationReasons.count) * 44
    }
    static var viewHeight: CGFloat {
        topPadding + cancelationReasonLableHeight + topTableViewPadding + bottomTableViewPadding + tableViewHeight
    }
}
