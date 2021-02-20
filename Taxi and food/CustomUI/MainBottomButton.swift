//
//  NextButton.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 15.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class MainBottomButton: UIButton {

    func setupAs(_ type: MainButtonTypes) {
        
        self.setTitle(MainButtonTitles.getTitle(for: type), for: .normal)
        
        switch type {
            
        case .next:
            setInActive()
        default:
            break
        }
    }
    
    func setActive() {
        self.isEnabled = true
        self.backgroundColor = Colors.buttonBlue.getColor()
    }
    
    func setInActive() {
        self.isEnabled = false
        self.backgroundColor = Colors.buttonGrey.getColor()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.clipsToBounds = true
        self.layer.cornerRadius = ViewsCornerRadiuses.medium.rawValue
        }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setInActive()
    }
}