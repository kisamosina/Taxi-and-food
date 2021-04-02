//
//  CGRect+Extension.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 02.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

extension CGRect {
    
    static func makeRect(height: CGFloat) -> CGRect {
        return CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: height)
    }
    
    static func makeRectWidthAndHeightScreen() -> CGRect {
        return CGRect(x: 0,
                      y: 0,
                      width: UIScreen.main.bounds.width,
                      height: UIScreen.main.bounds.height)

    }
}
