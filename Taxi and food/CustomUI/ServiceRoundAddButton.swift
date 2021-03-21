//
//  ServiceRoundAddButton.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 16.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class ServiceRoundAddButton: UIButton {
      
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.height / 2
    }

}
