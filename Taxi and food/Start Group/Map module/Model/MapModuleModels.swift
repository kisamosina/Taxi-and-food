//
//  MapModuleModels.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 04.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import UIKit

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

// MARK: - Tariff

final class Tariff {
    var isActive: Bool
    private let type: TariffType
    private let imageName: String
    private let feedTimeValue: Int
    private var priceValue: Double
    private var priceOldValue: Double?
    
    init(isActive: Bool, type: TariffType, imageName: String, feedTimeValue: Int, priceValue: Double, priceOldValue: Double? = nil) {
        self.isActive = isActive
        self.type = type
        self.imageName = imageName
        self.feedTimeValue = feedTimeValue
        self.priceValue = priceValue
        self.priceOldValue = priceOldValue
    }
}


extension Tariff {
    
    enum TariffType: String {
        case Standart, Premium, Buisness
    }
    
    var name: String {
        return type.rawValue
    }
}

extension Tariff {
    
    static func getTariffs() -> [Tariff] {
        
        let  standart = Tariff(isActive: true, type: .Standart, imageName: CustomImagesNames.iconTariffStandart.rawValue, feedTimeValue: 3, priceValue: 200, priceOldValue: nil)
        let  premium = Tariff(isActive: false, type: .Premium, imageName: CustomImagesNames.iconTariffPremium.rawValue, feedTimeValue: 6, priceValue: 300, priceOldValue: nil)
        let  buisness = Tariff(isActive: false, type: .Buisness, imageName: CustomImagesNames.iconTariffBusiness.rawValue, feedTimeValue: 9, priceValue: 400, priceOldValue: nil)
        
                
        return [standart, premium, buisness]
    }
}

extension Tariff {
    
    var tariffColor: UIColor {
        
        switch self.type {
            
        case .Standart:
            return Colors.tariffGreen.getColor()
        case .Premium:
            return Colors.tariffPurple.getColor()
        case .Buisness:
            return Colors.tariffGold.getColor()
        }
    }
    
    var tariffImage: UIImage? {
        return UIImage(named: self.imageName)
    }
}

extension Tariff {
    
    var price: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return "\(self.priceValue) руб"
        case .eng:
            return "\(self.priceValue) rub"
        }
    }
    
    var oldPrice: String? {
        
        guard let price = self.priceOldValue else { return nil }
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return "\(price) руб"
        case .eng:
            return "\(price) rub"
        }

    }
    
    var feedTime: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return "\(feedTimeValue) мин"
        case .eng:
            return "\(feedTimeValue) min"
        }
    }
}

extension Tariff {
    
    func setActive(_ value: Bool) {
        self.isActive = value
    }
}
