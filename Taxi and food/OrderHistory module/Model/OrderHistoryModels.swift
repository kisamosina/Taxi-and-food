//
//  OrderHistoryModels.swift
//  Taxi and food
//
//  Created by mac on 25/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct OrderHistoryResponse: Decodable {
    var data: [OrderHistoryResponseData]
}

struct OrderHistoryResponseData: Decodable {
    
    var id: Int
    var userId: Int
    var from: String?
    var to: String
    var credit: Int
    var distance: Int
    var price: Int
    var discount: Int
    var forPayment: Int
    var type: String
    var status: String
    var comment: [String]?
    var tariff: [TariffData]?
    var promoCodes: [PromocodeHistoryData]?
    var availablePromoCodes: [PromocodeHistoryData]?
    var taxi: [TaxiHistoryData]?
    var products: [ProductsHistoryData]?
    
}

struct TaxiHistoryData: Decodable {
    
    var id: Int
    var car: String
    var color: String
    var number: String
    var regionNumber: Int
    var imageMap: String
    var imageOrder: String
    var imageHistory: String
    
}

struct ProductsHistoryData: Decodable {
    var id: Int
    var name: String
    var icon: String?
    var isCategory: Bool
    var price: Int
    var producing: String
    var hit: Int
    var sale: Int
    var composition: String
    var weight: Int
    var unit: String
    
   
}
