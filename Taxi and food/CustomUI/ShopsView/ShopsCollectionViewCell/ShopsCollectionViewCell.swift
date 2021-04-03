//
//  ShopsCollectionViewCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 31.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class ShopsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var shopTitle: UILabel!
    @IBOutlet weak var shopImageView: UIImageView!

    @IBOutlet weak var substrateView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.setupShadowAndRoundCorner()
    }
    
    private func setupShadowAndRoundCorner() {
        
        self.layer.cornerRadius = ViewsCornerRadiuses.medium.rawValue
        self.substrateView.layer.cornerRadius = ViewsCornerRadiuses.medium.rawValue
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.layer.shadowOffset = CGSize(width: ShopsViewUIData.shadowOffsetWidth.rawValue,
                                         height: ShopsViewUIData.shadowOffsetWidth.rawValue)
        self.layer.shadowRadius = ShopsViewUIData.shadowRadius.rawValue
        self.layer.shadowOpacity = Float(ShopsViewUIData.shadowOpacity.rawValue)
        self.layer.masksToBounds = false
        
    }
    
    public func bind(_ shopModel: ShopResponseData) {
        self.shopTitle.text = shopModel.name
        self.shopImageView.webImage(shopModel.icon)
        setupShadowAndRoundCorner()
    }
}
