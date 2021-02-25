//
//  PromoViewController.swift
//  Taxi and food
//
//  Created by mac on 25/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol PromoViewProtocol: class {
    var interactor: PromoInteractorProtocol! { get set }
}

class PromoViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


}
