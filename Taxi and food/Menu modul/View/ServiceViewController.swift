//
//  ServiceViewController.swift
//  Taxi and food
//
//  Created by mac on 12/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit
import Foundation

class ServiceViewController: UIViewController {

    @IBOutlet var fillInTextView: UITextView!
    
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var buttonTopConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillInTextView.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.keyboardWillShow(constraint: buttonTopConstraint, notification: sender)

    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.keyboardWillHide(constraint: buttonTopConstraint, notification: sender)
        
    }

}

extension ServiceViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }

        return true
    }
}
