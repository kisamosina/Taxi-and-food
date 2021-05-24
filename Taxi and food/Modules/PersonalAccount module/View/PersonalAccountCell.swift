//
//  PersonalAccountCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 04.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PersonalAccountCell: UITableViewCell {

    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconImageView.image = nil
    }
    
    func setupCell(for model: PersonalAccountTableViewCellModel) {
        self.nameLabel.text = model.name
        guard let imageName = model.imageName else { return }
        self.iconImageView.image = UIImage(named: imageName)
    }
}
