//
//  PromoViewController.swift
//  Taxi and food
//
//  Created by mac on 25/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol PromoViewProtocol: AnyObject {
    var interactor: PromoInteractorProtocol! { get set }
    
    
}

class PromoViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var interactor: PromoInteractorProtocol!
    var models: [PromoOption]?
    let shortVc = PromoShortViewController()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactor = PromoInteractor(view: self)
        self.interactor.configure()
        
        tableView.register(PromoTableViewCell.self, forCellReuseIdentifier: PromoTableViewCell.identifier)


  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: nil, action: nil)
    }

}

extension PromoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = interactor.models[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PromoCell", for: indexPath) as? PromoTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: model)

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var type: String

        if indexPath.row == 0 {
            type = "food"

            performSegue(withIdentifier: "promoShort", sender: type)

        } else {

            type = "taxi"

            performSegue(withIdentifier: "promoShort", sender: type)
        }
    }
 
}

extension PromoViewController: PromoViewProtocol {}

extension PromoViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let nextViewController = segue.destination as? PromoShortViewController, let promoType = sender as? String {
            nextViewController.type = promoType
            
        }
  
    }
}

