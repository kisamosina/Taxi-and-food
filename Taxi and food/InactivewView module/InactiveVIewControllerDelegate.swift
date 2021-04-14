//
//  InactiveVIewControllerDelegate.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 18.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol InactiveViewControllerDelegate: class {
    
    func logOutButtonTapped()
    func beginSavePointsButtonTapped()
    func deleteButtonTapped()
    func approveButtonTapped()
}

extension InactiveViewControllerDelegate {
    func logOutButtonTapped() { }
    func beginSavePointsButtonTapped() { }
    func deleteButtonTapped() {}
    func approveButtonTapped() {}
}
