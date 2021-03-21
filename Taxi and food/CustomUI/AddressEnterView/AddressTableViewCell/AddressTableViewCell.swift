//
//  AddressTableViewCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 16.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeTitleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    public func setCell(by address: AddressResponseData) {
        self.placeTitleLabel.text = address.name
        self.addressLabel.text = address.address
    }
}
