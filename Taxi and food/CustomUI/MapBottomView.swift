//
//  MapBottomView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 19.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class MapBottomView: UIView {

    
    override func layoutSubviews() {
        super.layoutSubviews()
        let shadowLayer = CAShapeLayer()
        
        self.layer.cornerRadius = MapBottomViewUIData.cornerRadius.rawValue
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds,
                                        cornerRadius: self.layer.cornerRadius).cgPath
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.fillColor = self.backgroundColor?.cgColor
        shadowLayer.shadowColor = Colors.shadowColor.getColor().cgColor
        shadowLayer.shadowOffset = CGSize(width: MapBottomViewUIData.shadowOffsetWidth.rawValue,
                                          height: MapBottomViewUIData.shadowOffsetHeight.rawValue)
        shadowLayer.shadowOpacity = Float(MapBottomViewUIData.shadowOpacity.rawValue)
        shadowLayer.shadowRadius = MapBottomViewUIData.cornerRadius.rawValue
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
    
}
