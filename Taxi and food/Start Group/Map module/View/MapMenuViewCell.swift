//
//  MapMenuViewCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class MapMenuViewCell: UITableViewCell {

    @IBOutlet weak var menuItemImageView: UIImageView!
    @IBOutlet weak var menuItemLabel: UILabel!

    func setupCell(with menuItemImage: UIImage?, and menuItemText: String) {
        
        if let menuItemImage = menuItemImage {
            self.menuItemImageView.image =  menuItemImage
        } else {
            menuItemImageView.isHidden = true
        }
        
        self.menuItemLabel.text = menuItemText
        
    }
}
