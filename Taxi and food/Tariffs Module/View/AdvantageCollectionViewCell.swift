//
//  AdvantageCollectionViewCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 17.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class AdvantageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var advantageButton: UIButton!
    @IBOutlet weak var advantageLabel: UILabel!
    
    func showData(for advantage: TariffAdvantage, tariffColor: UIColor) {
        
        NetworkService.shared.loadImageData(for: advantage.icon) { [weak self] imgData in
            guard let self = self, let imgData = imgData  else { return }
                let image = UIImage(data: imgData)
            DispatchQueue.main.async {
                self.advantageButton.setImage(image, for: .normal)
            }
                
        }
        
        self.advantageButton.tintColor = tariffColor
        self.advantageLabel.text = advantage.name
        setupShadowAndRoundCorner()
    }
    
    private func setupShadowAndRoundCorner() {
        self.layer.cornerRadius = ViewsCornerRadiuses.medium.rawValue
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.layer.shadowOffset = CGSize(width: AdvantageViewShadowsData.shadowOffsetWidth.rawValue,
                                         height: AdvantageViewShadowsData.shadowOffsetWidth.rawValue)
        self.layer.shadowRadius = AdvantageViewShadowsData.shadowRadius.rawValue
        self.layer.shadowOpacity = Float(AdvantageViewShadowsData.shadowOpacity.rawValue)
        self.layer.masksToBounds = false
    }
}
