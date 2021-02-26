//
//  UIImageView+Extension.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 17.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func webImage(_ imageURL: String) {
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: NSString(string: imageURL)) {
            self.image = cachedImage
            return
        }
        
        NetworkService.shared.loadImageData(for: imageURL) { imageData in
            
            if let imageData = imageData {
                
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
                    self.image = image
                }
            } else {
                print ("Error while loading image")
            }
        }
    }
}
