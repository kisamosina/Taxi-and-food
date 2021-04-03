//
//  FoodCategoriesViewUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 03.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import UIKit

enum ShopDetailStringData: String {
    case nibFileName = "FoodCategoriesView"
    case collectioViewCellReuseId = "FoodCategoryCollectionViewCell"
}

enum ShopDetailSizeData: CGFloat {
    case collectionViewSummInsets = 60
    case collectionViewCellHeight = 120
    case collectionViewCellCornerRadius = 15
    case topConstraintConstant = 140
}


struct ShopDetailTexts {
    private enum RusTexts: String {
        case shop = "Магазин"
    }
    
    private enum EngTexts: String {
        case shop = "Магазин"
    }
    
    static var shopTitle: String {
        
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return RusTexts.shop.rawValue
        case .eng:
            return EngTexts.shop.rawValue
        }
    }
}
