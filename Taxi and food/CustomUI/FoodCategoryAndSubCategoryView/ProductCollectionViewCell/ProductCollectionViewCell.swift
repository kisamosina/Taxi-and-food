//
//  ProductCollectionViewCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 07.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    var cellData: ProductsResponseData!

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = FoodCategoryAndSubCategoryViewSizes.productCollectionViewCornerRadius.rawValue
        self.layer.cornerRadius = ViewsCornerRadiuses.small.rawValue
        self.layer.backgroundColor = UIColor.systemBackground.cgColor
        self.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.layer.shadowOffset = CGSize(width: AdvantageViewShadowsData.shadowOffsetWidth.rawValue,
                                         height: AdvantageViewShadowsData.shadowOffsetWidth.rawValue)
        self.layer.shadowRadius = AdvantageViewShadowsData.shadowRadius.rawValue
        self.layer.shadowOpacity = Float(AdvantageViewShadowsData.shadowOpacity.rawValue)
        self.layer.masksToBounds = false
    }
    
    public func bind(cellData: ProductsResponseData) {
        self.cellData = cellData
        self.productImageView.webImage(cellData.icon)
        self.productTitleLabel.text = cellData.name
        self.priceLabel.text = "\(cellData.price ?? 0) ₽"
        self.quantityLabel.text = "\(cellData.weight ?? 0) \(cellData.unit ?? "")"
    }
    
}


