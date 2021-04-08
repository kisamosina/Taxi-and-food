//
//  SubCategoryCollectionViewCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 07.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class SubCategoryCollectionViewCell: UICollectionViewCell {
    
    var cellData: ProductsResponseData!

    @IBOutlet weak var subCategoryNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = self.contentView.bounds.height / 2
    }
}

extension SubCategoryCollectionViewCell {
    
    func bind(subcategoryData: ProductsResponseData) {
        self.cellData = subcategoryData
        self.subCategoryNameLabel.text = subcategoryData.name
    }
}
