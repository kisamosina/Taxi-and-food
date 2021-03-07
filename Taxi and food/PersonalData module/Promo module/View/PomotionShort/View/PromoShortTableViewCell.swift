//
//  PromoShortTableViewCell.swift
//  Taxi and food
//
//  Created by mac on 25/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PromoShortTableViewCell: UITableViewCell {

    @IBOutlet var mainBackgroundView: UIView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var moreButton: UIButton!
    
    public func showPicture(for media: PromoMedia) {
        
        NetworkService.shared.loadImageData(for: media.url ?? "") { [weak self] result in
            guard let self = self  else { return }
            
            switch result {
            case .success(let imgData):
                let image = UIImage(data: imgData, scale: 2.4)
            
                self.contentView.backgroundColor = UIColor(patternImage: image ?? UIImage())
            case .failure(let error):
                print("Error while load advantage image: \(error.localizedDescription)")
            }
        }

        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = ViewsCornerRadiuses.medium.rawValue
       
        self.contentView.contentMode = .scaleAspectFit
        
        self.moreButton.setImage(UIImage(named: "moreButton"), for: .normal)


     
        
     

        self.layer.masksToBounds = false
    }

}

