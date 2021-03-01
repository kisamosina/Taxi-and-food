//
//  PaymentHistoryViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 27.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol PaymentHistoryViewProtocol: class {
    var interactor: PaymentHistoryInteractorProtocol! { get set}
    
    func setupViewElements()
}

class PaymentHistoryViewController: UIViewController {
    
    var interactor: PaymentHistoryInteractorProtocol!
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coverView: UIView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactor = PaymentHistoryInteractor(view: self)
        self.coverView.alpha = 0
        self.emptyLabel.text = PaymentHistoryViewControllerTexts.emptyLabelText
        self.setupTableView()
        self.setupViewElements()
     
    }
    
    //MARK: - IBActions
    
    
    //MARK: - Methods
    
    private func setupTableView() {
        let nib = UINib(nibName: PaymentHistoryIds.id.rawValue, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: PaymentHistoryIds.id.rawValue)
        self.tableView.tableFooterView = UIView()

    }
    
    private func showPaymentHistoryDetailView() {
        let payDetailView = PaymentHistoryDetailView.instanceFromNib()
        payDetailView.frame = CGRect(x: 15, y: self.view.bounds.height/2 - 345/2, width: 324, height: 345)
        self.coverView.alpha = 1
        self.view.addSubview(payDetailView)
    }
}
//MARK: - PaymentHistoryViewProtocol extension

extension PaymentHistoryViewController: PaymentHistoryViewProtocol {
    
    func setupViewElements() {
        
        DispatchQueue.main.async {
            self.tableView.isHidden = self.interactor.paymentHistotyData.isEmpty
            self.searchBar.isHidden = self.interactor.paymentHistotyData.isEmpty
            self.backgroundImageView.isHidden = !self.interactor.paymentHistotyData.isEmpty
            self.emptyLabel.isHidden = !self.interactor.paymentHistotyData.isEmpty
            
            if !self.interactor.paymentHistotyData.isEmpty {
                self.tableView.reloadData()
            }
        }
        
    }
}

//MARK:- UITableViewDataSource, UITableViewDelegate

extension PaymentHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.paymentHistotyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PaymentHistoryIds.id.rawValue, for: indexPath) as? PaymentHistoryTableViewCell
        else { return UITableViewCell() }
        
        let data = self.interactor.paymentHistotyData[indexPath.row]
        
        cell.setupCell(by: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showPaymentHistoryDetailView()
    }
    
}
