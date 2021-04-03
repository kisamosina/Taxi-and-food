//
//  Paddings.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 03.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

//Bottom indent
var bottomPadding: CGFloat {
    let window = UIApplication.shared.windows[0]
    return window.safeAreaInsets.bottom
}

//Top indent
var topPadding: CGFloat {
    let window = UIApplication.shared.windows[0]
    return window.safeAreaInsets.top
}
