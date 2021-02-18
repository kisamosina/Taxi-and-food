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
    
    func webImage(_ imageURL: String, placeHolder: UIImage? = nil ) {
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: NSString(string: imageURL)) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: imageURL) else {
            print("Invalid URL")
            self.image = placeHolder
            return
        }
        
        self.image = placeHolder
        
        DispatchQueue.global(qos: .utility).async {
            do {
                let imageData: Data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    let image = UIImage(data: imageData)
                    self.image = image
                }
                
            } catch {
                print("Unable to load data: \(error)")
                self.image = placeHolder
            }
        }
        
    }
}
