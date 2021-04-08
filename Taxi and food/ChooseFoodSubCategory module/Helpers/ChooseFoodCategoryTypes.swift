//
//  ChooseFoodCategoryTypes.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 08.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

enum ChooseFoodSubCategoriesViewControllerMode {
    case subcategoryOnly(String, String, [ProductsResponseData])
    case subcategoriesWithProducts(String, String, [ProductsResponseData])
}
