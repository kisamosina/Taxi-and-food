//
//  PhotosCell.swift
//  Taxi and food
//
//  Created by mac on 14/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    func initCell(userPhoto: UIImage) {
        self.imageView.image = userPhoto
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = ViewsCornerRadiuses.medium.rawValue
    }
    
    
    
    
}
