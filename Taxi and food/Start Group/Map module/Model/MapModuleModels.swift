//
//  MapModuleModels.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 04.04.2021.
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

// MARK: - Food Categories

struct FoodCategoriesResponse: Decodable {
    var data: FoodCategoriesResponseData
}

struct FoodCategoriesResponseData: Decodable {
    var id: Int
    var name: String
    var categories: [FoodCategoriesResponseData.FoodCategory]
    var schedule: String
    var description: String
    var address: String
    var icon: String
}


extension FoodCategoriesResponseData {
    
    struct FoodCategory: Decodable {
        var id: Int
        var name: String
        var icon: String
        var isCategory: Bool
    }
    
}

// MARK: - Food subcategories


