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
    
    //Bottom indent
    private var bottomPadding: CGFloat {
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.bottom
    }
    
    //Top indent
    private var topPadding: CGFloat {
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.top
    }

    
    typealias BottomConstraintHanler = (NSLayoutConstraint) -> Void
    typealias VerticalConstraintsHandler = (NSLayoutConstraint, NSLayoutConstraint) -> Void
        
    func setupConstraints(for superview: UIView, viewHeight: CGFloat, bottomContraintConstant: CGFloat, with bottomConstraintHanler: BottomConstraintHanler) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
                
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottomContraintConstant)
        let trailingConstraint = self.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        let heightConstraint = self.heightAnchor.constraint(equalToConstant:viewHeight)
        let leadingConstraint = self.leadingAnchor.constraint(equalTo: superview.leadingAnchor)
        
        NSLayoutConstraint.activate([bottomConstraint, heightConstraint, leadingConstraint, trailingConstraint])
        
        bottomConstraintHanler(bottomConstraint)
    }

    func setupConstraints(for superview: UIView, bottomConstraintConstant: CGFloat, with bottomConstraintHanler: BottomConstraintHanler) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottomConstraintConstant)
        bottomConstraint.isActive = true
        bottomConstraintHanler(bottomConstraint)
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: -topPadding).isActive = true
    }
    
    func setupConstraints(for superView: UIView, topConstraint: CGFloat, bottomConstraint: CGFloat, constraintHandler: VerticalConstraintsHandler) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = self.topAnchor.constraint(equalTo: superView.topAnchor, constant: UIScreen.main.bounds.height)
        
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: UIScreen.main.bounds.height + FoodCategoriesViewSizeData.topConstraintConstant.rawValue)
        
        bottomConstraint.isActive = true
        topConstraint.isActive = true
        constraintHandler(topConstraint, bottomConstraint)
        
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    }
    
    func setupConstraints(topConstant: CGFloat, height: CGFloat) {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: topConstant).isActive = true
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
