//
//  TariffTitleButton.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 18.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class TariffTitleButton: UIButton {
    
    func setColor(_ color: UIColor) {
        self.backgroundColor = color
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = Colors.buttonGrey.getColor()
        self.frame = CGRect(x: 0, y: 0, width: TariffButtonsSizes.tariffTitleButtonWidth.rawValue, height: TariffButtonsSizes.tariffTitleButtonHeight.rawValue)
        self.clipsToBounds = true
        self.layer.cornerRadius = TariffButtonsSizes.tariffTitleButtonCornerRadius.rawValue
        self.titleLabel?.font = .systemFont(ofSize: TariffButtonsSizes.tariffTitleButtonFontSize.rawValue)
    }
    
}


