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
        self.layer.cornerRadius = MapBottomViewUIData.cornerRadius.rawValue
        self.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.layer.shadowOpacity = Float(MapBottomViewUIData.shadowOpacity.rawValue)
        self.layer.shadowRadius = MapBottomViewUIData.cornerRadius.rawValue
        self.layer.shadowOffset = CGSize(width: MapBottomViewUIData.shadowOffsetWidth.rawValue,
                                         height: MapBottomViewUIData.shadowOffsetWidth.rawValue)
        self.layer.masksToBounds = false
        
    }
    
}
