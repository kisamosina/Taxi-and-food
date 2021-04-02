//
//  Animator.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 02.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

typealias AnimationCompletion = (Bool) -> Void

class Animator {
    
    static let shared = Animator()
    
    private init() {}
    
    enum AnimationType {
        case usualBottomAnimation(UIView, NSLayoutConstraint)
        case menuViewAnimation(UIView, NSLayoutConstraint, NSLayoutConstraint)
    }
    
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
    
    //Show view
    
    func showView(animationType: AnimationType, from superView: UIView, for distance: CGFloat? = nil, completion: AnimationCompletion? = nil) {
        
        switch animationType {
        
        case .usualBottomAnimation(let view, let constraint):
            UsualBotomViewAnimation.showView(superview: superView, view: view, for: distance ?? self.bottomPadding, bottomConstraint: constraint, completion: completion)
        case .menuViewAnimation(let view, let leadingConstraint, let trailingConstraint):
            MenuViewAnimation.showView(superview: superView, view: view, leadingConstraint: leadingConstraint, trailingConstraint: trailingConstraint, completion: completion)
        }
        
    }
    
    //Hide view
    func hideView(animationType: AnimationType, from superView: UIView, viewHeight: CGFloat? = nil, for distance: CGFloat? = nil, completion: AnimationCompletion? = nil) {
        
        switch animationType {
        
        case .usualBottomAnimation(let view, let constraint):
            guard let viewHeight = viewHeight else { return }
            UsualBotomViewAnimation.hideView(superview: superView, view: view, viewHeight: viewHeight, for: distance ?? bottomPadding, bottomConstraint: constraint, completion: completion)
        case .menuViewAnimation(let view, let leadingConstraint, let trailingConstraint):
            MenuViewAnimation.hideView(superview: superView, view: view, leadingConstraint: leadingConstraint, trailingConstraint: trailingConstraint, completion: completion)
        }
    }
    
}

// MARK: - Usual general animation for slide from bottom screen

fileprivate class UsualBotomViewAnimation {
    
    static func showView(superview: UIView, view: UIView, for distance: CGFloat,  bottomConstraint: NSLayoutConstraint, completion: AnimationCompletion? = nil) {
        
        DispatchQueue.main.async {
            
            view.alpha = 0
            
            bottomConstraint.constant = distance
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: {
                            superview.layoutIfNeeded()
                            view.alpha = 1
                           },
                           completion: completion)
            
        }
    }
    
    static func hideView(superview: UIView, view: UIView, viewHeight: CGFloat, for distance: CGFloat, bottomConstraint: NSLayoutConstraint, completion: AnimationCompletion? = nil) {
        DispatchQueue.main.async {
            bottomConstraint.constant = viewHeight + distance
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: {
                            superview.layoutIfNeeded()
                            view.alpha = 0
                           },
                           completion: completion)
        }
    }
}


fileprivate class MenuViewAnimation {
    
    static func showView(superview: UIView, view: UIView, leadingConstraint: NSLayoutConstraint, trailingConstraint: NSLayoutConstraint, completion: AnimationCompletion? = nil) {
        DispatchQueue.main.async {
            
            leadingConstraint.constant = 0
            trailingConstraint.constant = MapViewControllerConstraintsData.maximizedTrailingMenuViewConstant.rawValue
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: {
                            superview.layoutIfNeeded()
                            view.alpha = 1
                           },
                           completion: completion)
            
        }
    }
    
    static func hideView(superview: UIView, view: UIView, leadingConstraint: NSLayoutConstraint, trailingConstraint: NSLayoutConstraint, completion: AnimationCompletion? = nil) {
        
        DispatchQueue.main.async {
            leadingConstraint.constant = -UIScreen.main.bounds.width
            trailingConstraint.constant = UIScreen.main.bounds.width
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: {
                            superview.layoutIfNeeded()
                            view.alpha = 0
                           },
                           completion: completion)
        }
    }
    
}
