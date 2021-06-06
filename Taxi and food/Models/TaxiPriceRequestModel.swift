//
//  TaxiPriceRequestModel.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 28.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct TaxiPriceRequestModel: Codable {
    
    let from: String
    let to: String
    let promoCodes: [String]?
    let credit: Int?
}
