//
//  PromoDestinationView.swift
//  Taxi and food
//
//  Created by mac on 02/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PromoDestinationView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupView()

        self.layer.cornerRadius = MapPromoDestinationViewUIData.cornerRadius.rawValue

        self.layer.masksToBounds = false

    }
    
    func setupView() {
self.insertSubview(imageView, at: 0)
NSLayoutConstraint.activate([
    imageView.topAnchor.constraint(equalTo: self.topAnchor),
    imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
    imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
    imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    
    
])
    }

}

