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
    
    func configureViewElements()
    
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
        
        self.interactor = OrderHistotyInteractor(view: self)
        configureUI()
        setupTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK: - Methods
    private func configureUI() {
        self.emptyLabel.text = OrderHistoryViewControllerTexts.emptyLabelText
        self.segmentedControl.setTitle(OrderHistoryViewControllerTexts.firstSegmentTitle, forSegmentAt: 0)
        self.segmentedControl.setTitle(OrderHistoryViewControllerTexts.secondSegmentTitle, forSegmentAt: 1)
        self.navigationItem.title = OrderHistoryViewControllerTexts.title
        
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: OrderHistoryIds.id.rawValue, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: OrderHistoryIds.id.rawValue)
        self.tableView.tableFooterView = UIView()

    }

}

//MARK: - OrderHistoryViewProtocol extension

extension OrderHistoryViewController: OrderHistoryViewProtocol {

    func configureViewElements() {
        
        DispatchQueue.main.async {
            self.tableView.isHidden = self.interactor.orderHistoryData.isEmpty
            self.segmentedControl.isHidden = self.interactor.orderHistoryData.isEmpty
            self.backgroundImageView.isHidden = !self.interactor.orderHistoryData.isEmpty
            self.emptyLabel.isHidden = !self.interactor.orderHistoryData.isEmpty
            
            if !self.interactor.orderHistoryData.isEmpty {
                self.tableView.reloadData()
            }
        }
        
    }
}

extension OrderHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.orderHistoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderHistoryIds.id.rawValue, for: indexPath) as? OrderHistoryTableViewCell
        else { return UITableViewCell() }
        
        let data = interactor.orderHistoryData[indexPath.row]
        cell.setUpCell(by: data)
        
        return cell
    }
    
    
}


