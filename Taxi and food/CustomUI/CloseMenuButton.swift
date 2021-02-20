//
//  CloseMenuButton.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class CloseMenuButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.setImage(UIImage(named: CustomImagesNames.X.rawValue),
                      for: .normal)
        self.tintColor = Colors.XTintColor.getColor()
        
    }
    
}
