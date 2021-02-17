//
//  AdvantageCollectionViewCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 17.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class AdvantageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: AdvantageView!
    @IBOutlet weak var advantageImageView: UIImageView!
    @IBOutlet weak var advantageLabel: UILabel!

    func showData(for advantage: TariffAdvantage) {
        self.advantageImageView.webImage(advantage.icon)
        self.advantageImageView.backgroundColor = Colors.tariffGreen.getColor()
        self.advantageLabel.text = advantage.name
    }
}
