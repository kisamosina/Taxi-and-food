//
//  SubCategoryCollectionViewCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 07.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class SubCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var subCategoryNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = self.contentView.bounds.height / 2
    }
}

extension SubCategoryCollectionViewCell {
    
    func bind(subcategoryName: String) {
        self.subCategoryNameLabel.text = subcategoryName
    }
}
