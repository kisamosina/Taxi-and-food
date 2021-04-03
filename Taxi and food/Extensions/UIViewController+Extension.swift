//
//  UIViewController+Extension.swift
//  Taxi and food
//
//  Created by mac on 12/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func keyboardWillShow(constraint: NSLayoutConstraint, notification: NSNotification, padding: CGFloat = 0) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if constraint.constant == 0 {
                constraint.constant -= keyboardSize.height - padding
            }
        }
    }
    
    func keyboardWillHide(constraint:NSLayoutConstraint, notification: NSNotification) {
        constraint.constant = 0
    }

    func getKeyBoardHeight(notification: NSNotification) -> CGFloat? {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return nil }
        return keyboardSize.height
    }
}

extension UIViewController {
    
    func getViewController(storyboardId: String, viewControllerId: String ) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        return storyboard.instantiateViewController(identifier: viewControllerId)
    }
}


