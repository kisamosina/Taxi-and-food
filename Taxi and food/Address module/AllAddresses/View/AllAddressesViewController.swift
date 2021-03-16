//
//  AllAddressesViewController.swift
//  Taxi and food
//
//  Created by mac on 11/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol AllAddressesViewProtocol {
    
    var interactor: AllAddressesInteractorProtocol! { get set }
    var cellModel: [AddressResponseData]? { get set }
    
//    func setTableViewData(_ addressData: AddressResponseData)
    
    func updateTableViewData()
    
    
    
    
}

class AllAddressesViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var interactor: AllAddressesInteractorProtocol!
    
    var cellModel: [AddressResponseData]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        configureUI()
        
        self.interactor = AllAddressesInteractor(view: self)
        self.interactor.getAllAddresses()

    }
    
    private func configureUI() {
        self.navigationItem.title = AddressViewControllerText.navigationItemTitleText
    }

}


extension AllAddressesViewController: AllAddressesViewProtocol {
    func updateTableViewData() {
        DispatchQueue.main.async {
        self.tableView.reloadData()
            print("cell model")
            print(self.cellModel)
            print("array of addresses")
            print(self.cellModel)
        }
    }
}

extension AllAddressesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellModel?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewControllers.AllAddressesViewController.rawValue, for: indexPath) as? AllAddressesCell else {
            return UITableViewCell()
            
        }
        cell.configure()
        cell.addressNameLabel.text = cellModel?[indexPath.row].name
        cell.addressLabel.text = cellModel?[indexPath.row].address
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AddressViewController", sender: self)
    }
    
    
}


