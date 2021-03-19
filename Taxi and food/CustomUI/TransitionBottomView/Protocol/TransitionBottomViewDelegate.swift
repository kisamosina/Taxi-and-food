//
//  TransitionBottomViewDelegate.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 12.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol TransitionBottomViewDelegate: class {
    func mainButtonTapped(for viewType: TransitionBottomViewTypes)
    func auxButtonTapped(for viewType: TransitionBottomViewTypes)
    func userHasSwipedDown(for viewType: TransitionBottomViewTypes)
}
