//
//  FoodCategoryAndSubCategoryView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 07.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class FoodSubCategoryAndProductView: CustomBottomView {

    //MARK: - IBOutlets
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubViews()
    }
    
    // MARK: - Methods
    
    override func initSubViews() {
        super.initSubViews()
        self.loadFromNib(nibName: FoodCategoryAndSubCategoryViewStringData.nibFileName.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.containerView.backgroundColor = .clear
        self.setupConstraints()
        let cellSubCategoryNib = UINib(nibName: FoodCategoryAndSubCategoryViewStringData.subCategoryNibFileName.rawValue, bundle: nil)
        let cellProductNib = UINib(nibName: FoodCategoryAndSubCategoryViewStringData.productsNibFileName.rawValue, bundle: nil)
        subCategoryCollectionView.register(cellSubCategoryNib, forCellWithReuseIdentifier: FoodCategoryAndSubCategoryViewStringData.subCategoryNibFileName.rawValue)
        productsCollectionView.register(cellProductNib, forCellWithReuseIdentifier:  FoodCategoryAndSubCategoryViewStringData.productsNibFileName.rawValue)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

}


extension FoodSubCategoryAndProductView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
                
        case subCategoryCollectionView:
            return 0
            
        case productsCollectionView:
            return 0
        
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
                
        case subCategoryCollectionView:
            return SubCategoryCollectionViewCell()
            
        case productsCollectionView:
            return ProductCollectionViewCell()
        
        default:
            return UICollectionViewCell()
        }
    }
      
}
