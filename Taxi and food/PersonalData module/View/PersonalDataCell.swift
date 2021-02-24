//
//  PersonalDataCell.swift
//  Taxi and food
//
//  Created by mac on 21/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PersonalDataCell: UITableViewCell {
    
    static let identifier = "personalData"
    
    var textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier reusableIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reusableIdentifier)
        contentView.addSubview(textField)

        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        textField.frame = CGRect(x: 25, y: 0, width: contentView.frame.size.width - 20, height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textField.text = nil
    }
    
       public func configure(with model: PersonalDataOption) {
        textField.placeholder = model.title
    
       }
}
