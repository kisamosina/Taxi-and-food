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
        
//        self.interactor = PromoInteractor(view: self)
//        self.interactor.configure()
        
    

        
    }

}

extension PromoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PromoShort", for: indexPath) as? PromoShortTableViewCell else {
            return UITableViewCell()
        }

        return cell
        
    }
    
    
}

extension PromoViewController: PromoViewProtocol {}
