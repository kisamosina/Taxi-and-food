//
//  FoodCategoryViewDelegate.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 03.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol FoodViewCategoryViewDelegate: AnyObject {
    
    func backButtonTapped()
    func userHasSwipedDown()
    func infoButtonTapped()
    func shopSelected(shopId: Int, with categoryId: Int)
}
