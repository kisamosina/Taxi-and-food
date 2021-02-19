//
//  MapRoundButton.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 19.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class MapRoundButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shadowLayer = CAShapeLayer()
        
        self.layer.cornerRadius = self.frame.height/2
        
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds,
                                        cornerRadius: self.layer.cornerRadius).cgPath
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.fillColor = self.backgroundColor?.cgColor
        shadowLayer.shadowColor = Colors.shadowColor.getColor().cgColor
        shadowLayer.shadowOffset = CGSize(width: MapRoundButtonUIData.shadowOffsetWidth.rawValue,
                                          height: MapRoundButtonUIData.shadowOffsetHeight.rawValue)
        shadowLayer.shadowOpacity = Float(MapRoundButtonUIData.shadowOpacity.rawValue)
        shadowLayer.shadowRadius = MapRoundButtonUIData.shadowRadius.rawValue
        self.layer.insertSublayer(shadowLayer, at: 0)

    }
    
}
