//
//  ChooseFoodSubCategoriesInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 08.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

class ChooseFoodSubCategoriesInteractor: ChooseFoodSubCategoriesInteractorProtocol {
   
    internal weak var view: ChooseFoodSubCategoriesViewProtocol!
    
    var mode: ChooseFoodSubCategoriesViewControllerMode
    
    required init(view: ChooseFoodSubCategoriesViewProtocol, mode: ChooseFoodSubCategoriesViewControllerMode) {
        self.view = view
        self.mode = mode
    }
    
    
    func getSubcategories(from array: [ProductsResponseData]) -> [ProductsResponseData] {
        return array.filter { $0.isCategory }
    }
    
    func getProducts(from array: [ProductsResponseData]) -> [ProductsResponseData] {
        return array.filter{ !$0.isCategory }
    }
}
