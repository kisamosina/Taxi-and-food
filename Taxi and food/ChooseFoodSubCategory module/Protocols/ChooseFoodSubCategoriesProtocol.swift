//
//  ChooseFoodSubCategoriesProtocol.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 08.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol  ChooseFoodSubCategoriesViewProtocol: class  {
    
    var interactor: ChooseFoodSubCategoriesInteractorProtocol! { get set }
    
    func showSubCategories(as mode: ChooseFoodSubCategoriesViewControllerMode)
}

protocol ChooseFoodSubCategoriesInteractorProtocol: class {
    
    var view: ChooseFoodSubCategoriesViewProtocol! { get }
    
    var mode: ChooseFoodSubCategoriesViewControllerMode { get }
    
    init (view: ChooseFoodSubCategoriesViewProtocol, mode: ChooseFoodSubCategoriesViewControllerMode)
    
    func getSubcategories(from array: [ProductsResponseData]) -> [ProductsResponseData]
    
    func getProducts(from array: [ProductsResponseData]) -> [ProductsResponseData]
}
