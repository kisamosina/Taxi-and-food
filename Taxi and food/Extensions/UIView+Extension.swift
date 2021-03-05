//
//  UIView+Extension.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 05.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

extension UIView {
    func loadFromNib(nibName: String) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
    }
}
