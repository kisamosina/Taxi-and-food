//
//  SettingsSwitchCell.swift
//  Taxi and food
//
//  Created by mac on 19/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import UIKit

class SettingsSwitchCell: UITableViewCell {
    static let identifier = "SwitchCell"
    
    private var titleLabel: UILabel = {
        let tittleLabel = UILabel()
        tittleLabel.numberOfLines = 1
        return tittleLabel
    }()
    
    private let theSwitch: UISwitch = {
        let theSwitch = UISwitch()
        return theSwitch
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reusableIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reusableIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(theSwitch)
        
        contentView.clipsToBounds = true
        accessoryType = .none
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        theSwitch.sizeToFit()
        theSwitch.frame = CGRect(x: (contentView.frame.size.width - theSwitch.frame.size.width - 10), y: (contentView.frame.size.height - theSwitch.frame.size.height) / 2, width: theSwitch.frame.size.width, height: theSwitch.frame.size.height)
        
        titleLabel.frame = CGRect(x: 25, y: 0, width: contentView.frame.size.width - 20, height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        theSwitch.isOn = false
    }
    
    public func configure(with model: SettingsSwitchOption) {
        titleLabel.text = model.title
        theSwitch.isOn = model.isOn
        
    }
    
    
    
   
}
