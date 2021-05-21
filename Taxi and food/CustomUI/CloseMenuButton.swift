//
//  CloseMenuButton.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

@IBDesignable class CloseMenuButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImageAndColor()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setImageAndColor()
        
    }
    
    private func setImageAndColor() {
        self.setImage(UIImage(named: CustomImagesNames.X.rawValue), for: .normal)
        self.tintColor = Colors.XTintColor.getColor()
        self.backgroundColor = Colors.closeButtonGrey.getColor()
    }
}
