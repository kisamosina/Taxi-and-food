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
        self.layer.cornerRadius = TaxiOrderViewSizesData.tariffCellShadowRadius.rawValue
        self.layer.backgroundColor = UIColor.systemBackground.cgColor
        self.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.layer.shadowOffset = CGSize(width: TaxiOrderViewSizesData.tariffCellShadowOffsetWidth.rawValue,
                                         height: TaxiOrderViewSizesData.tariffCellShadowOffsetHeight.rawValue)
        self.layer.shadowRadius = TaxiOrderViewSizesData.tariffCellShadowRadius.rawValue
        self.layer.shadowOpacity = Float(TaxiOrderViewSizesData.tariffCellShadowOpacity.rawValue)
        self.layer.masksToBounds = false
    }
}


extension TaxiOrderCollectionViewCell {
    
    func bindCell(for tariff: Tariff) {
        self.tariffNameLabel.text = tariff.name
        self.tariffImageButton.setImage(tariff.tariffImage, for: .normal)
        self.tariffImageButton.imageView?.contentMode = .scaleAspectFit
        self.feedTimeLabel.text = tariff.feedTime
        self.priceWithoutDiscountLabel.setCrossedText(tariff.oldPrice)
        self.priceLabel.text = tariff.price
        
        if tariff.isActive {
            self.setActive(tariff: tariff)
        } else {
            self.setInactive()
        }
    }
    
    private func setActive(tariff: Tariff) {
        self.containerView.backgroundColor = .systemBackground
        self.tariffNameLabel.textColor = Colors.fontGrey.getColor()
        self.tariffImageButton.tintColor = tariff.tariffColor
        self.feedTimeLabel.textColor = tariff.tariffColor
        self.priceLabel.textColor = UIColor.label
        self.priceWithoutDiscountLabel.textColor = Colors.fontGrey.getColor()
    }
    
    private func setInactive() {
        self.containerView.backgroundColor = Colors.backGroundGreyActive.getColor()
        self.tariffNameLabel.textColor = Colors.buttonGrey.getColor()
        self.tariffImageButton.tintColor = Colors.buttonGrey.getColor()
        self.feedTimeLabel.textColor = Colors.buttonGrey.getColor()
        self.priceLabel.textColor = Colors.fontGrey.getColor()
        self.priceWithoutDiscountLabel.textColor = Colors.fontGrey.getColor()
    }
}
