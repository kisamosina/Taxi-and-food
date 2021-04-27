//
//  TaxiOrderCollectionViewCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 27.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class TaxiOrderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var tariffNameLabel: UILabel!

    @IBOutlet weak var tariffImageButton: UIButton!
    
    @IBOutlet weak var feedTimeLabel: UILabel!
    
    @IBOutlet weak var priceWithoutDiscountLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = TaxiOrderViewSizesData.tariffCellShadowRadius.rawValue
//        self.layer.cornerRadius = TaxiOrderViewSizesData.tariffCellShadowRadius.rawValue
        self.layer.backgroundColor = UIColor.systemBackground.cgColor
        self.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.layer.shadowOffset = CGSize(width: TaxiOrderViewSizesData.tariffCellShadowOffsetWidth.rawValue,
                                         height: TaxiOrderViewSizesData.tariffCellShadowOffsetHeight.rawValue)
        self.layer.shadowRadius = TaxiOrderViewSizesData.tariffCellShadowRadius.rawValue
        self.layer.shadowOpacity = Float(TaxiOrderViewSizesData.tariffCellShadowOpacity.rawValue)
        self.layer.masksToBounds = false
    }
}
