//
//  TaxiOrderStatusTableViewCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class TaxiOrderStatusTableViewCell: UITableViewCell {
    
    static let reuseId = String(describing: TaxiOrderStatusTableViewCell.self)

    @IBOutlet weak var parameterLabel: UILabel!
    @IBOutlet weak var parameterImageView: UIImageView!
    
}

extension TaxiOrderStatusTableViewCell {
    
    public func bind(_ model: TaxiOrderStatusTableViewCellModel) {
        parameterLabel.setText(text: model.parameter, of: .normal(15))
        parameterImageView.image = UIImage(named: model.parameterImageName)
    }
}
