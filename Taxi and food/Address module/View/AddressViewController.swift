//
//  AddressViewController.swift
//  Taxi and food
//
//  Created by mac on 05/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController {

    @IBOutlet var nameTextView: UITextView!
    @IBOutlet var addressTextView: UITextView!
    @IBOutlet var commentTextView: UITextView!
    
    @IBOutlet var officeTextView: UITextView!
    @IBOutlet var entranceTextView: UITextView!
    
    @IBOutlet var intercomTextView: UITextView!
    
    @IBOutlet var floorTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextViews()

      
    }
    
    func configureTextViews() {
        self.nameTextView.text = "Название адреса"
        
    }

}
