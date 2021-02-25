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
    
    var interactor: PromoInteractorProtocol!
    var models: [PromoOption]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactor = PromoInteractor(view: self)
        self.interactor.configure()
        
        tableView.register(PromoTableViewCell.self, forCellReuseIdentifier: PromoTableViewCell.identifier)

        
    }

}

extension PromoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = interactor.models[indexPath.row]
        print(model)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PromoTableViewCell.identifier, for: indexPath) as? PromoTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: model)
        
        print(cell)
        
        return cell
        
    }
    
    
}

extension PromoViewController: PromoViewProtocol {}
