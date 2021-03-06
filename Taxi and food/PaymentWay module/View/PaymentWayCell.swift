//
//  PaymentWayCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 06.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PaymentWayCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    
    func setupCell(for model: PaymentWayTableViewCellModel) {
        
        self.titleLabel.text = model.title
        self.checkMarkImageView.image = UIImage(named: model.checkMarkImage)
        guard let iconName = model.iconName else { return }
        self.iconImageView.image = UIImage(named: iconName)
    }
}
