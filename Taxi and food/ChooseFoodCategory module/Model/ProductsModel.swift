//
//  ProductsModel.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 07.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct ProductsResponse: Decodable {
    var data: [ProductsResponseData]
}

struct ProductsResponseData: Decodable {
    
    var id: Int
    var name: String
    var icon: String
    var isCategory: Bool
    var price: Int?
    var producing: String?
    var hit: Int?
    var sale: Int?
    var composition: String?
    var weight: Int?
    var unit: String?
}
