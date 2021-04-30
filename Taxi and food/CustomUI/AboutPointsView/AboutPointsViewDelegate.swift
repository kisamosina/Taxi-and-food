//
//  AboutPointsViewDelegate.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 18.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol AboutPointsViewDelegate: AnyObject {
    
    func closeButtonTapped()
    func beginSavePointsButtonTapped()
    func userHasSwipedViewDown()
}
