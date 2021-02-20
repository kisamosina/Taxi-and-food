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
                
        self.layer.cornerRadius = self.frame.height/2
               
        self.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.layer.shadowOpacity = Float(MapRoundButtonUIData.shadowOpacity.rawValue)
        self.layer.shadowRadius = MapRoundButtonUIData.shadowRadius.rawValue
        self.layer.shadowOffset = CGSize(width: MapRoundButtonUIData.shadowOffsetWidth.rawValue,
                                         height: MapRoundButtonUIData.shadowOffsetHeight.rawValue)
               self.layer.masksToBounds = false

    }
    
}
