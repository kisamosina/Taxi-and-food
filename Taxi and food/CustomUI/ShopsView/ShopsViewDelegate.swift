//
//  ShopsViewDelegate.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 03.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol ShopsViewDelegate: AnyObject {
    
    func userHasSwipedDownView()
    func goToShop(_ shopId: Int)
}
