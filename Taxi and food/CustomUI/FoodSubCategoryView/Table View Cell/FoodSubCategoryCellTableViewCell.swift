//
//  FoodSubCategoryCellTableViewCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 04.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class FoodSubCategoryCellTableViewCell: UITableViewCell {

    @IBOutlet weak var subcategoryTitleLabel: UILabel!
    
    func bind(subcategoryTitle: String) {
        self.subcategoryTitleLabel.text = subcategoryTitle
    }
}
