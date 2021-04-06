//
//  ChooseFoodProtocols.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 06.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol ChooseFoodInteractorProtocol {
    
    var view: ChooseFoodViewProtocol { get }
    
    var foodCategories: FoodCategoriesResponseData { get }
    
    init(view: ChooseFoodViewProtocol, foodCategories: FoodCategoriesResponseData)
    
}

protocol ChooseFoodViewProtocol {
    
    var interactor: ChooseFoodInteractorProtocol! { get  set }
    
    func setInteractor(interactor: ChooseFoodInteractorProtocol)
}


protocol ChooseFoodViewControllerDelegate: class {
    
    func userHasSwiped()
}
