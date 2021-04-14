//
//  FullPathCollectionViewCell.swift
//  Taxi and food
//
//  Created by mac on 09/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class FullPathCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var costLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconImage.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = ViewsCornerRadiuses.medium.rawValue
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.layer.shadowOffset = CGSize(width: AdvantageViewShadowsData.shadowOffsetWidth.rawValue,
                                         height: AdvantageViewShadowsData.shadowOffsetWidth.rawValue)
        self.layer.shadowRadius = AdvantageViewShadowsData.shadowRadius.rawValue
        self.layer.shadowOpacity = Float(AdvantageViewShadowsData.shadowOpacity.rawValue)
        self.layer.masksToBounds = false
    }
    
    func showData(for tariff: FullPathCellData) {
        self.titleLabel.text = tariff.title
        self.iconImage.image = tariff.icon
        self.durationLabel.text = tariff.duration
        self.durationLabel.textColor = tariff.color
        self.costLabel.text = tariff.cost

    }

}
