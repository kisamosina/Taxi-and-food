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

extension UIView {
    
    typealias BottomConstraintHanler = (NSLayoutConstraint) -> Void
        
    func setupConstraints(for superview: UIView, viewHeight: CGFloat, bottomContraintConstant: CGFloat, with bottomConstraintHanler: BottomConstraintHanler) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
                
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottomContraintConstant)
        let trailingConstraint = self.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        let heightConstraint = self.heightAnchor.constraint(equalToConstant:viewHeight)
        let leadingConstraint = self.leadingAnchor.constraint(equalTo: superview.leadingAnchor)
        
        NSLayoutConstraint.activate([bottomConstraint, heightConstraint, leadingConstraint, trailingConstraint])
        
        bottomConstraintHanler(bottomConstraint)
    }

}
