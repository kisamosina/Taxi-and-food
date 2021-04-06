//
//  ChooseFoodInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 06.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

class ChooseFoodInteractor: ChooseFoodInteractorProtocol {
    
    var view: ChooseFoodViewProtocol
    
    var foodCategories: FoodCategoriesResponseData     
    
    required init(view: ChooseFoodViewProtocol, foodCategories: FoodCategoriesResponseData) {
        self.view = view
        self.foodCategories = foodCategories
    }
    
}
