//
//  ShopsResponse.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

// MARK: - Shops

struct ShopsResponse: Decodable {
    var data: [ShopResponseData]
}

struct ShopResponseData: Decodable {
    var id: Int
    var name: String
    var icon: String
}
