//
//  PromoDestinationView.swift
//  Taxi and food
//
//  Created by mac on 02/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PromoDestinationView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        fix the color
        self.backgroundColor = .white

        self.layer.cornerRadius = MapPromoDestinationViewUIData.cornerRadius.rawValue

        self.layer.masksToBounds = false

    }
    
    func setupView() {
//        fix rhe data
        self.nameLabel.text = "dostavka"
    }

}
