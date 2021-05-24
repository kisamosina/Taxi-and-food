//
//  ChooseFoodSubCategoriesViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 08.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class ChooseFoodSubCategoriesViewController: SubstrateViewController {
    
    var interactor: ChooseFoodSubCategoriesInteractorProtocol!
    weak var delegate: ChooseFoodSubCategoriesViewControllerDelegate?
    
    //Subcategory view
    var subcategoryView: FoodSubCategoryView!
    var subcategoryViewBottomConstraint: NSLayoutConstraint!
    
    //Subcategory and Products view
    
    var subcategoryAndProductView: FoodSubCategoryAndProductView!
    var subcategoryAndProductViewTopConstraint: NSLayoutConstraint!
    var subcategoryAndProductViewBottomConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showSubCategories(as: self.interactor.mode)
    }
}

//MARK: - ChooseFoodSubCategoriesViewProtocol
extension ChooseFoodSubCategoriesViewController: ChooseFoodSubCategoriesViewProtocol {
    
    func showSubCategories(as mode: ChooseFoodSubCategoriesViewControllerMode) {
        
        switch mode {
        
        case .subcategoryOnly(let shopTitle, let categoryTitle, let subcategories):
            self.showSubcategoryView(shopTitle: shopTitle, categoryTitle: categoryTitle, viewData: subcategories)
        case .subcategoriesWithProducts(let shopTitle, let categoryTitle, let subcategoriesAndProduct):
            self.showSubcategoryAndProductsView(shopTitle: shopTitle, categoryTitle: categoryTitle, viewData: subcategoriesAndProduct)
        }
    }
}

//MARK: - Setup Subcategories View

extension ChooseFoodSubCategoriesViewController {
    
    //Show View
    
    private func showSubcategoryView(shopTitle: String, categoryTitle: String, viewData: [ProductsResponseData]) {
        
        let subcategoryViewHeight = self.interactor.getSubcategoryViewHeight(cellNumbers: viewData.count)
        
        self.subcategoryView = FoodSubCategoryView(frame: CGRect.makeRect(height: subcategoryViewHeight))
        
        self.view.addSubview(subcategoryView)
        
        self.subcategoryView.bind(shopTitle: shopTitle, categoryTitle: categoryTitle, and: viewData)
        
        self.subcategoryView.delegate = self
        
        self.subcategoryView.setupConstraints(for: self.view,
                                              viewHeight: subcategoryViewHeight,
                                              bottomContraintConstant: subcategoryViewHeight) { bottomConstraint in
            self.subcategoryViewBottomConstraint = bottomConstraint
        }
        
        Animator.shared.showView(animationType: .usualBottomAnimation(self.subcategoryView, self.subcategoryViewBottomConstraint),
                                 from: self.view)
    }
    
    //Hide view
    private func hideSubCategoryView(hasSwipedDown: Bool = false, isBackButtonTapped: Bool = false) {
        
        let viewHeight = self.subcategoryView.bounds.height
        
        Animator.shared.hideView(animationType: .usualBottomAnimation(self.subcategoryView, self.subcategoryViewBottomConstraint), from: self.view, viewHeight: viewHeight) {[weak self] _ in
            guard let self = self else { return }
            self.subcategoryView.removeFromSuperview()
            self.subcategoryView = nil
            self.subcategoryViewBottomConstraint = nil
            if isBackButtonTapped { self.delegate?.backToCategoriesButtonTapped()}
            self.dismiss(animated: false, completion: nil)
            if hasSwipedDown { self.delegate?.userHasSwipedView()}
        }
    }
}
//MARK: - FoodSubCategoryViewDelegate
extension ChooseFoodSubCategoriesViewController: FoodSubCategoryViewDelegate {
   
    func userHasSwipedDown() {
        self.hideSubCategoryView(hasSwipedDown: true)
    }
    
    
    func backButtonHasTapped() {
        self.hideSubCategoryView(hasSwipedDown: false, isBackButtonTapped: true)
    }
}

//MARK: - Setup Subcategories and Products View

extension ChooseFoodSubCategoriesViewController {
    
    private func showSubcategoryAndProductsView(shopTitle: String, categoryTitle: String, viewData: [ProductsResponseData]) {
        
        self.subcategoryAndProductView = FoodSubCategoryAndProductView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height,
                                                                                     width: UIScreen.main.bounds.width,
                                                                                     height: UIScreen.main.bounds.height - ChooseFoodSubCategoriesViewSizes.subCategoryViewTopConstraintConstant.rawValue))
        
        self.view.addSubview(subcategoryAndProductView)
        
        
        
        self.subcategoryAndProductView.bind(shopTitle: shopTitle, categoryTitle: categoryTitle, subcategoryCollectionViewData: interactor.getSubcategories(from: viewData), productsCollectionViewData: interactor.getProducts(from: viewData))
        
        self.subcategoryAndProductView.delegate = self
        
        self.subcategoryAndProductView.setupConstraints(for: self.view,
                                                        topConstraint: UIScreen.main.bounds.height,
                                                        bottomConstraint: UIScreen.main.bounds.height - ChooseFoodSubCategoriesViewSizes.subCategoryViewTopConstraintConstant.rawValue)
        {[weak self] (topConstraint, bottomConstraint) in
            guard let self = self else { return }
            self.subcategoryAndProductViewTopConstraint = topConstraint
            self.subcategoryAndProductViewBottomConstraint = bottomConstraint
        }
        
        Animator.shared.showView(animationType: .categoriesView(self.subcategoryAndProductView, self.subcategoryAndProductViewTopConstraint, self.subcategoryAndProductViewBottomConstraint), from: self.view)
    }
    
    //Hide view
    private func hideSubcategoryAndProductsView(hasSwipedDown: Bool = false, isBackButtonTapped: Bool = false) {
        
        Animator.shared.hideView(animationType: .categoriesView(self.subcategoryAndProductView, self.subcategoryAndProductViewTopConstraint, self.subcategoryAndProductViewBottomConstraint), from: self.view) {[weak self] _ in
            guard let self = self else { return }
            self.subcategoryAndProductView.removeFromSuperview()
            self.subcategoryAndProductView = nil
            self.subcategoryAndProductViewTopConstraint = nil
            self.subcategoryAndProductViewBottomConstraint = nil
            self.dismiss(animated: false, completion: nil)
            if isBackButtonTapped { self.delegate?.backToCategoriesButtonTapped() }
            if hasSwipedDown { self.delegate?.userHasSwipedView() }
        }
    }
    
    
}

//MARK: - FoodSubcategoryAndProductViewDelegate

extension ChooseFoodSubCategoriesViewController: FoodSubcategoryAndProductViewDelegate {
    func userHasSwipedDownFoodSubcategoryAndProductView() {
        self.hideSubcategoryAndProductsView(hasSwipedDown: true)
    }

    func backButtonTapped() {
        self.hideSubcategoryAndProductsView(isBackButtonTapped: true)
    }
    
    
}
