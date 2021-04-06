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
    var mediaId: Int?
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PromoShortCell", for: indexPath) as? PromoShortTableViewCell else {
            return UITableViewCell()
        }
        
        let title = interactor.promos[indexPath.row].title ?? ""
        let media = interactor.promos[indexPath.row].media[1].url ?? ""
        
        cell.setupWith(url: media, title: title)
       

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mediaId = interactor.promos[indexPath.row].id
        print("id here")
        print(interactor.promos[indexPath.row].id)
        
        performSegue(withIdentifier: "description", sender: mediaId)
    }
    

}

extension PromoShortViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let nextViewController = segue.destination as? PromoDescriptionViewController, let mediaType = sender as? Int {
            nextViewController.id = mediaType
            nextViewController.modalPresentationStyle = .popover
          
        }
  
    }
}

extension PromoShortViewController: PromoShortViewProtocol {
    func reload() {
        
        DispatchQueue.main.async {
        
        self.tableView.reloadData()
            
        }
        
    }
}
