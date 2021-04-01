//
//  PersonalDataTableViewCell.swift
//  Taxi and food
//
//  Created by mac on 31/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PersonalDataTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
    }
    
    func configureUI(with model: PersonalDataUIOption) {
        self.titleLabel.text = model.title
         if model.accessoryType == true {
             self.accessoryType = .disclosureIndicator
        }
        
        self.titleLabel.textColor = model.color
    }
    

}
