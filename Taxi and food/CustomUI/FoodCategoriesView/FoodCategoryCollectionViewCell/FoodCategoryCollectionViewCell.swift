//
//  FoodCategoryCollectionViewCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 03.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class FoodCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productCategoryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productCategoryImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = FoodCategoriesViewSizeData.collectionViewCellCornerRadius.rawValue
    }
    
    public func bindCell(by category: FoodCategoriesResponseData.FoodCategory) {
        self.productCategoryLabel.text = category.name
        self.productCategoryImageView.webImage(category.icon)
    }

}
