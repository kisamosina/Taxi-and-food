//
//  AllAddressesCell.swift
//  Taxi and food
//
//  Created by mac on 11/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class AllAddressesCell: UITableViewCell {
    

    @IBOutlet var addressNameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    
       public func configure() {
        
        
        self.contentView.clipsToBounds = true
        self.accessoryType = .disclosureIndicator
        
        
//        addressNameLabel.text = model.data.
//        addressNameLabel.text = model.address
        
    
       }
   
}
