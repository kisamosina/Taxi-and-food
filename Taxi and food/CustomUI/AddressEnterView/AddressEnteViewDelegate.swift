//
//  AddressEnteViewDelegate.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 19.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol AddressEnterViewDelegate: class {
    
    func userHasSwipedViewDown()
    func nextButtonTapped()
    func mapButtonViewTapped()
}
