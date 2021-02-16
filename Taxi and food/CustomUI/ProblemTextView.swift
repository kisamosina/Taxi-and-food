//
//  ProblemTextView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 16.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class ProblemTextView: UITextView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.borderColor = Colors.greyBorderColor.getColor().cgColor
        self.layer.borderWidth = BordersWidths.standart.rawValue
        self.clipsToBounds = true
        self.layer.cornerRadius = ViewsCornerRadiuses.medium.rawValue
    }
    

}
