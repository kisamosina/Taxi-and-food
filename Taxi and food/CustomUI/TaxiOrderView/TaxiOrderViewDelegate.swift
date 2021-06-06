//
//  TaxiOrderViewDelegate.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 28.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import UIKit

protocol TaxiOrderViewDelegate: AnyObject {
    
    func viewHasSwipedDown()
    func promocodeButtonTapped()
    func pointsButtonTapped()
    func tariffSelected(tariffId: Int, tariffPrice: Double)
    func orderButtonTapped()
}
