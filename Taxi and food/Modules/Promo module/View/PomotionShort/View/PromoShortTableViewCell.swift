//
//  PromoShortTableViewCell.swift
//  Taxi and food
//
//  Created by mac on 25/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PromoShortTableViewCell: UITableViewCell {

    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var moreButton: UIButton!
    
    var myimageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    
    func setup() {
        
        self.insertSubview(myimageView, at: 0)
        NSLayoutConstraint.activate([
            myimageView.topAnchor.constraint(equalTo: self.topAnchor),
            myimageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            myimageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            myimageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
            
        ])
        self.layer.cornerRadius = ViewsCornerRadiuses.medium.rawValue
       
        self.contentView.contentMode = .scaleAspectFit
        
        self.moreButton.setImage(UIImage(named: "moreButton"), for: .normal)

        self.layer.masksToBounds = false
        
        
    }
    
    func setImage(url: String) {
        self.imageView?.webImage(url)
    }

}

