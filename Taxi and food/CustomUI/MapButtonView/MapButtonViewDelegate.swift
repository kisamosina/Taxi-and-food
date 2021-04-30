//
//  MapButtonViewDelegate.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 21.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol MapButtonViewDelegate: AnyObject {
    func mapButtonTapped()
}

protocol MapButtonDelegate: AnyObject {
    
    func mapButtonTapped(destinationAddress: String?)
    
}
