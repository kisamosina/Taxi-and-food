//
//  NewCardEnterViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 08.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class NewCardEnterViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var cardEnterView: CardEnterView!
        
    @IBOutlet weak var cardEnterViewYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addKeyboardObserver()

    }
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillAppear(notification: NSNotification) {
        self.keyboardWillShow(constraint: cardEnterViewYConstraint, notification: notification)
    }
    
    @objc func keyboardWillDisappear(notification: NSNotification) {
        self.keyboardWillHide(constraint: cardEnterViewYConstraint, notification: notification)
    }

}
