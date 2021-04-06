//
//  ChooseFoodViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 06.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class ChooseFoodViewController: SubstrateViewController, ChooseFoodViewProtocol {
    
    var interactor: ChooseFoodInteractorProtocol!
    
    weak var delegate: ChooseFoodViewControllerDelegate!
    
    var inactiveView: InactiveView = InactiveView()
    
    //Food category (shop detail) view
    
    private var foodCategoryView: FoodCategoriesView!
    private var foodCategoryTopConstraint: NSLayoutConstraint!
    private var foodCategoryViewBottomConstraint: NSLayoutConstraint!
    
    //ShopDetailView
    
    private var shopDetailView: ShopDetailView!
    private var shopDetailViewBottomConstraint: NSLayoutConstraint!
            
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showFoodCategoryView(interactor.foodCategories)
    }
    
    func setInteractor(interactor: ChooseFoodInteractorProtocol) {
        self.interactor = interactor
    }
    
}

//MARK: - Food categories methods

extension ChooseFoodViewController {
    
    //Show Food Category view
    private func showFoodCategoryView(_ shopDetailData: FoodCategoriesResponseData) {
        
        self.foodCategoryView = FoodCategoriesView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height,
                                                                 width: UIScreen.main.bounds.width,
                                                                 height: UIScreen.main.bounds.height - FoodCategoriesViewSizeData.topConstraintConstant.rawValue))
        
        self.view.addSubview(foodCategoryView)
        
        self.foodCategoryView.setFoodData(shopDetailData)
        
        self.foodCategoryView.delegate = self
        
        self.foodCategoryView.setupConstraints(for: self.view,
                                               topConstraint: UIScreen.main.bounds.height,
                                               bottomConstraint: UIScreen.main.bounds.height - FoodCategoriesViewSizeData.topConstraintConstant.rawValue)
        {[weak self] (topConstraint, bottomConstraint) in
            guard let self = self else { return }
            self.foodCategoryTopConstraint = topConstraint
            self.foodCategoryViewBottomConstraint = bottomConstraint
        }
        
        Animator.shared.showView(animationType: .categoriesView(self.foodCategoryView, self.foodCategoryTopConstraint, self.foodCategoryViewBottomConstraint), from: self.view)
    }
    
    //Hide Food Category view
    private func hideFoodCategoryView(hasSwipedDown: Bool = false) {
        
        Animator.shared.hideView(animationType: .categoriesView(self.foodCategoryView, self.foodCategoryTopConstraint, self.foodCategoryViewBottomConstraint), from: self.view) {[weak self] _ in
            guard let self = self else { return }
            self.foodCategoryView.removeFromSuperview()
            self.foodCategoryView = nil
            self.foodCategoryTopConstraint = nil
            self.foodCategoryViewBottomConstraint = nil
            self.dismiss(animated: false, completion: nil)
            if hasSwipedDown { self.delegate.userHasSwiped() }
        }
    }
}

//MARK: - FoodViewCategoryViewDelegate

extension ChooseFoodViewController: FoodViewCategoryViewDelegate {
    
    func infoButtonTapped() {
        self.showShopDetailView(interactor.foodCategories)
    }
    
    
    func backButtonTapped() {
        self.hideFoodCategoryView()
    }
    
    func userHasSwipedDown() {
        self.hideFoodCategoryView(hasSwipedDown: true)
    }
}

// MARK: - InactiveViewDelegate

extension ChooseFoodViewController: InactiveViewDelegate {
    func userHasTapped() {
        self.hideShopDetailView()
    }
    
}

//MARK: - Food categories methods

extension ChooseFoodViewController {

    private func showShopDetailView(_ shopData: FoodCategoriesResponseData) {
        
        inactiveView.frame = self.view.bounds
        inactiveView.delegate = self
        self.view.addSubview(inactiveView)
        
        
        self.shopDetailView = ShopDetailView(frame: CGRect.makeRect(height: ShopDetailViewSizes.viewHeight.rawValue))
        
        self.view.addSubview(self.shopDetailView)
        
        self.shopDetailView.delegate = self
        
        self.shopDetailView.bindView(for: interactor.foodCategories)
        
        self.shopDetailView.setupConstraints(for: self.view, viewHeight: ShopDetailViewSizes.viewHeight.rawValue, bottomContraintConstant: ShopDetailViewSizes.viewHeight.rawValue + bottomPadding) {[weak self] bottomConstraint in
            guard let self = self else { return }
            self.shopDetailViewBottomConstraint = bottomConstraint
        }
        
        Animator.shared.showView(animationType: .usualBottomAnimation(self.shopDetailView, self.shopDetailViewBottomConstraint), from: self.view)
    }
    
    private func hideShopDetailView() {
        Animator.shared.hideView(animationType: .usualBottomAnimation(self.shopDetailView, shopDetailViewBottomConstraint), from: self.view, viewHeight: ShopDetailViewSizes.viewHeight.rawValue) { [weak self] _ in
            guard let self = self else { return }
            self.shopDetailView.removeFromSuperview()
            self.shopDetailView = nil
            self.inactiveView.removeFromSuperview()
        }
    }
}

// MARK: - ShopDetailViewDelegate

extension ChooseFoodViewController: ShopDetailViewDelegate {
   
    func closeButtonTapped() {
        self.hideShopDetailView()
    }
}