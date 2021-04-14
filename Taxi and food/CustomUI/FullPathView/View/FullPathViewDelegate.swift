//
//  FullPathViewDelegate.swift
//  Taxi and food
//
//  Created by mac on 13/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol FullPathViewDelegate: class {
    
    func userHasSwipedFullPathViewDown()
    func mapButtonViewDidTapped(destinationAddress: String?)
    func nextButtonDidTapped()
}

