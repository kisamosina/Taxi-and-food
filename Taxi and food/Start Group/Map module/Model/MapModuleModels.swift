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
    let id: Int
    let name: String
    private let tariffPrice: Double
    private let imageName: String
    private let feedTimeValue: Int
    private var priceValue: Double
    private var priceOldValue: Double?
    
    init(isActive: Bool, id: Int, name: String, imageName: String, feedTimeValue: Int, priceValue: Double, priceOldValue: Double? = nil) {
        self.isActive = isActive
        self.id = id
        self.name = name
        self.tariffPrice = priceValue
        self.imageName = imageName
        self.feedTimeValue = feedTimeValue
        self.priceValue = priceValue
        self.priceOldValue = priceOldValue
    }
}


extension Tariff {
    
    enum TariffType: String {
        case standart = "Standart"
        case premium = "Premium"
        case business = "Business"
        case unknown
    }
        
    private var type: TariffType {
        guard let tariffType = TariffType(rawValue: name) else { return .unknown }
        return tariffType
    }

}

extension Tariff {
        
    static func getTariffs(from tariffData: [TariffData]) -> [Tariff] {
        
        return tariffData.map { data in
            
            switch data.name {
            
            case TariffType.standart.rawValue:
                return Tariff(isActive: true, id: data.id, name: data.name, imageName: CustomImagesNames.iconTariffStandart.rawValue, feedTimeValue: 3, priceValue: 200)
            case TariffType.premium.rawValue:
                return Tariff(isActive: false, id: data.id, name: data.name, imageName: CustomImagesNames.iconTariffPremium.rawValue, feedTimeValue: 6, priceValue: 300)
            case TariffType.business.rawValue:
                return Tariff(isActive: false, id: data.id, name: data.name, imageName: CustomImagesNames.iconTariffBusiness.rawValue, feedTimeValue: 9, priceValue: 400)
            default:
                return Tariff(isActive: false, id: data.id, name: data.name, imageName: data.name, feedTimeValue: 0, priceValue: 0)
                
            }
        }
    }
}

extension Tariff {
    
    var tariffColor: UIColor {
        
        switch self.type {
            
        case .standart:
            return Colors.tariffGreen.getColor()
        case .premium:
            return Colors.tariffPurple.getColor()
        case .business:
            return Colors.tariffGold.getColor()
        case .unknown:
            return Colors.lightGrey.getColor()
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
            return "\(Int(self.priceValue.rounded())) руб"
        case .eng:
            return "\(Int(self.priceValue.rounded())) rub"
        }
    }
    
    var oldPrice: String? {
        
        guard let price = self.priceOldValue else { return nil }
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return "\(Int(price.rounded())) руб"
        case .eng:
            return "\(Int(price.rounded())) rub"
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
        
        if !value && priceOldValue != nil {
            priceValue = priceOldValue!
            priceOldValue = nil
        }
    }
}

extension Tariff {
    
    func setNewPrice(newPrice: Double) {
        self.priceOldValue = self.priceValue
        self.priceValue = newPrice
    }
    
    func getTariffPrice() -> Double {
        return tariffPrice
    }
}
