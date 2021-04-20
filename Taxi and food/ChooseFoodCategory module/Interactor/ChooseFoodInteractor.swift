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
        
        NetworkService.shared.makeRequest(for: resource, completion:  {[ weak self ] result in
            
            guard let self  = self else  { return }
            
            switch result {
            
            case .success(let response):
                
                let data = response.data
                
                let products = data.filter { products -> Bool in return !products.isCategory}
                let categoryName = self.foodCategories.categories.first { $0.id == categoryId }?.name
                
                if products.isEmpty {
                    self.view.show(subcategoriesAndProduct: .subcategoryOnly(self.foodCategories.name, categoryName ?? "No category", data))
                } else {
                    self.view.show(subcategoriesAndProduct: .subcategoriesWithProducts(self.foodCategories.name, categoryName ?? "No category", data))
                }
                                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })

    }
    
}
