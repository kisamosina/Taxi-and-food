//
//  TaxiPlaceOrderRequestModel.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 25.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct TaxiPlaceOrderRequestModel: Codable {
    
    let tariff: Int
    let from: String
    let to: String
    let paymentCard: Int?
    let paymentMethod: String
    let promoCodes: [String]?
    let credit: Int?
}
