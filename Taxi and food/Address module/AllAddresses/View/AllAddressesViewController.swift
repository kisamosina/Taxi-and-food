//
//  AllAddressesViewController.swift
//  Taxi and food
//
//  Created by mac on 11/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class AllAddressesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

     
    }
    
    private func configureUI() {
        self.navigationItem.title = AddressViewControllerText.navigationItemTitleText
    }
    


}
