//
//  OrderHistoryViewController.swift
//  Taxi and food
//
//  Created by mac on 25/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol OrderHistoryViewProtocol: class {
    var interactor: OrderHistotyInteractorProtocol! { get set }
    
}

class OrderHistoryViewController: UIViewController {
    
    var interactor: OrderHistotyInteractorProtocol!
    
    //MARK: - IBOutlets
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var emptyLabel: UILabel!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
       
    }


}
