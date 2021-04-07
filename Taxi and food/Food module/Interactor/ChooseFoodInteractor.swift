//
//  ChooseFoodInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 06.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

class ChooseFoodInteractor: ChooseFoodCategoryInteractorProtocol {
    
    internal weak var view: ChooseFoodCategoryViewProtocol!
    
    var foodCategories: FoodCategoriesResponseData     
    
    required init(view: ChooseFoodCategoryViewProtocol, foodCategories: FoodCategoriesResponseData) {
        self.view = view
        self.foodCategories = foodCategories
    }
    
    func makeSubCategoryRequest(for shopId: Int, and categoryId: Int) {
        
        guard let user = PersistanceStoreManager.shared.getUserData()?.first else { return }
        let path = ProductsRequestNetworkPaths.productsAndSubCategories.rawValue.getServerPath(userId: Int(user.id), shopId: shopId, categoryId: categoryId)
        
        let resource = Resource<ProductsResponse>(path: path, requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource) { result in
            switch result {
            
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
}
