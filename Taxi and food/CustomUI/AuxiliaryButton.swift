//
//  AuxiliaryButton.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 09.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class AuxiliaryButton: UIButton {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 17)
    }
    
    func setupAs(type: AuxiliaryButtonTypes) {
        
        switch type {
        
        case .cancel:
            self.setTitle(AuxiliaryButtonTitles.cancelTitle, for: .normal)
        }
    }
}
