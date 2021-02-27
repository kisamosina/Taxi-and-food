//
//  PromoShortViewController.swift
//  Taxi and food
//
//  Created by mac on 25/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol PromoShortViewProtocol: class {
    var interactor: PromoShortInteractorProtocol! { get set }
    
    
    func reload()
}

class PromoShortViewController: UIViewController {
    
    var interactor: PromoShortInteractorProtocol!
    var data: [PromoShortData] = []
    var type: String?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        self.interactor = PromoShortInteractor(view: self)
        self.interactor.getPromos(type: type!)
        

    }

}


extension PromoShortViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        
        return interactor.promos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PromoShortCell", for: indexPath) as? PromoShortTableViewCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = interactor.promos[indexPath.row].title

        return cell
    }
}

extension PromoShortViewController: PromoShortViewProtocol {
    func reload() {
        
        DispatchQueue.main.async {
        
        self.tableView.reloadData()
    }
        
    }
}
