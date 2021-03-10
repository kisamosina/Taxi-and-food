//
//  CardEnterViewDelegate.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 09.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol CardEnterViewDelegate: class {
    
func catchCardData(cardNumber: String, expirationDate: String, cvv: String)
    
func callApproveView()
    
}
