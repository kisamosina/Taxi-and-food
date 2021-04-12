//
//  SubstrateViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 06.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class SubstrateViewController: UIViewController {
    
    var isTapGestureEnabled = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.isTapGestureEnabled {
            self.addGestureRecognizer()
        }
        self.view.backgroundColor = Colors.InactiveViewColor.getColor()
        
    }
    
  private  func addGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(userHasTapped(_:)))
        self.view.addGestureRecognizer(tapRecognizer)
    }

    @objc func userHasTapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
    }
}
