//
//  LogOutButton.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 03.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class LogOutButton: UIButton {

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.logOutButtonBorderColor.getColor().cgColor
       
    }
   

}
