//
//  UIViewController+Extension.swift
//  Taxi and food
//
//  Created by mac on 12/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func keyboardWillShow(constraint: NSLayoutConstraint, notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if constraint.constant == 0 {
                constraint.constant -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(constraint:NSLayoutConstraint, notification: NSNotification) {
        constraint.constant = 0
    }

    
}
