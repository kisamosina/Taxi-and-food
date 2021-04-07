//
//  ProductCollectionViewCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 07.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = ViewsCornerRadiuses.small.rawValue
        self.layer.backgroundColor = UIColor.systemBackground.cgColor
        self.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.layer.shadowOffset = CGSize(width: AdvantageViewShadowsData.shadowOffsetWidth.rawValue,
                                         height: AdvantageViewShadowsData.shadowOffsetWidth.rawValue)
        self.layer.shadowRadius = AdvantageViewShadowsData.shadowRadius.rawValue
        self.layer.shadowOpacity = Float(AdvantageViewShadowsData.shadowOpacity.rawValue)
        self.layer.masksToBounds = false
    }
    
}


