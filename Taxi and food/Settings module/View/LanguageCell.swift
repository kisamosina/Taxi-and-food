//
//  LanguageCell.swift
//  Taxi and food
//
//  Created by mac on 19/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell {
    
    static let identifier = "LanguageCell"
    
    private var titleLabel: UILabel = {
        let tittleLabel = UILabel()
        tittleLabel.numberOfLines = 1
        return tittleLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reusableIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reusableIdentifier)
        contentView.addSubview(titleLabel)

        contentView.clipsToBounds = true
        accessoryType = .none
       }
       
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       override func layoutSubviews() {
           super.layoutSubviews()

           titleLabel.frame = CGRect(x: 25, y: 0, width: contentView.frame.size.width - 20, height: contentView.frame.size.height)
       }
       
       override func prepareForReuse() {
           super.prepareForReuse()
           titleLabel.text = nil
       }
       
    public func configure(with model: LanguageOption) {
        titleLabel.text = model.title
    
       }
    
    

 

}
