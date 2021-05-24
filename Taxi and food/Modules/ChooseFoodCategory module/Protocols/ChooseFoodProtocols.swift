//
//  ChooseFoodProtocols.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 06.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol ChooseFoodCategoryInteractorProtocol: AnyObject {
    
    var view: ChooseFoodCategoryViewProtocol! { get }
    
    var foodCategories: FoodCategoriesResponseData { get }
    
    init(view: ChooseFoodCategoryViewProtocol, foodCategories: FoodCategoriesResponseData)
    
    func makeSubCategoryRequest(for shopId: Int, and categoryId: Int)
    
}

protocol ChooseFoodCategoryViewProtocol: AnyObject {
    
    var interactor: ChooseFoodCategoryInteractorProtocol! { get  set }
    
    func setInteractor(interactor: ChooseFoodCategoryInteractorProtocol)
    
    func show(subcategoriesAndProduct: ChooseFoodSubCategoriesViewControllerMode)
}


protocol ChooseFoodCategoryViewControllerDelegate: AnyObject {
    
    func userHasSwiped()
}
