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

    func updateTableViewData()
   
}

class AllAddressesViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var backImage: UIImageView!
    
    
    @IBOutlet var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var backImageTopConstraint: NSLayoutConstraint!
    var interactor: AllAddressesInteractorProtocol!
    
    var cellModel: [AddressResponseData]?
    
    var modelToPass: AddressResponseData?
    var navigationItemName: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        configureUI()
        
        self.interactor = AllAddressesInteractor(view: self)
        self.interactor.getAllAddresses()
        
        self.backImageTopConstraint.constant += self.view.frame.height + 200
       
        print("self.backImageTopConstraint.constant")
        print(self.backImageTopConstraint.constant)
        

        
        print("self.view.frame.height")
        print(self.view.frame.height)
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        var heightOfTableView: CGFloat = 0.0
//
//        let cells = tableView.visibleCells
//        for cell in cells {
//            heightOfTableView += cell.frame.height
//        }
//        self.backImageTopConstraint.constant = self.view.frame.height - heightOfTableView - self.backImage.frame.height
//        print("cells count")
//        print(cells.count)
//    }
    

    
    private func configureUI() {
        self.navigationItem.title = AddressViewControllerText.navigationItemTitleText
        
        self.backImage = UIImageView(image: UIImage(named: "addressFull"))
        
      
    }

}


extension AllAddressesViewController: AllAddressesViewProtocol {
    func updateTableViewData() {
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
            var heightOfTableView: CGFloat = 0.0

            let cells = self.tableView.visibleCells
            for cell in cells {
                heightOfTableView += cell.frame.height
                print(cell.frame.height)
            }
            self.backImageTopConstraint.constant = self.view.frame.height - heightOfTableView - self.backImage.frame.height
            
            if self.cellModel?.count != 0 {
                self.backImage = UIImageView(image: UIImage(named: "addressFull"))
            }
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
        self.navigationItemName = cellModel?[indexPath.row].name
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        modelToPass = cellModel?[indexPath.row]
        
        performSegue(withIdentifier: "AddressViewController", sender: modelToPass)

    }
    
    
}


extension AllAddressesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddressViewController" {
            let vc = segue.destination as! AddressViewController
            vc.commenCourierTextField.isHidden = false
            vc.addressInfo = sender as? AddressResponseData
            
        }
    }
}

