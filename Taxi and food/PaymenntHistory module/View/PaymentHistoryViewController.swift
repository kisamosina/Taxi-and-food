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
    var payDetailView: PaymentHistoryDetailView!
    var vcState: PaymentHistoryViewControllerStates = .normal
    
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
        self.searchBar.placeholder = PaymentHistoryViewControllerTexts.searchBarPlaceholder
        self.setupTableView()
        self.setupViewElements()
        self.addGestureRecognizerToCoverView()
     
    }
    
    //MARK: - IBActions
    
    
    //MARK: - Methods
    
    private func setupTableView() {
        let nib = UINib(nibName: PaymentHistoryIds.id.rawValue, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: PaymentHistoryIds.id.rawValue)
        self.tableView.tableFooterView = UIView()

    }
    
    private func showPaymentHistoryDetailView(for cell: CGRect, and data: PaymentsHistoryResponseData) {
        
        let rect = CGRect(x: cell.origin.x,
                          y: cell.origin.y,
                          width: PaymentHistoryDetailViewUIData.width.rawValue,
                          height: PaymentHistoryDetailViewUIData.height.rawValue)
        
        self.payDetailView = PaymentHistoryDetailView(frame: rect)
        self.payDetailView.alpha = 0
        self.payDetailView.setupView(by: data)
        self.view.addSubview(payDetailView)
        
        //Animation
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.coverView.alpha = 1
                        payDetailView.alpha = 1
                        payDetailView.frame = CGRect(x: self.view.bounds.width/2 - PaymentHistoryDetailViewUIData.width.rawValue/2,
                                                     y: self.view.bounds.height/2 - PaymentHistoryDetailViewUIData.height.rawValue/2,
                                                     width: PaymentHistoryDetailViewUIData.width.rawValue,
                                                     height: PaymentHistoryDetailViewUIData.height.rawValue)
                       },
                       completion: nil)
    }
    
    private func addGestureRecognizerToCoverView() {
        let touchRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnCoverView))
        self.coverView.addGestureRecognizer(touchRecognizer)
    }
    
    @objc func tapOnCoverView() {
        self.coverView.alpha = 0
        self.payDetailView.removeFromSuperview()
    }
}
//MARK: - PaymentHistoryViewProtocol extension

extension PaymentHistoryViewController: PaymentHistoryViewProtocol {
    
    func setupViewElements() {
        
        DispatchQueue.main.async {
            self.tableView.isHidden = self.interactor.paymentHistoryData.isEmpty
            self.searchBar.isHidden = self.interactor.paymentHistoryData.isEmpty
            self.backgroundImageView.isHidden = !self.interactor.paymentHistoryData.isEmpty
            self.emptyLabel.isHidden = !self.interactor.paymentHistoryData.isEmpty
            
            if !self.interactor.paymentHistoryData.isEmpty {
                self.tableView.reloadData()
            }
        }
        
    }
}

//MARK:- UITableViewDataSource, UITableViewDelegate

extension PaymentHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch vcState{
        
        case .normal:
            return interactor.paymentHistoryData.count
        case .searched(let paymentHistoryData):
            return paymentHistoryData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PaymentHistoryIds.id.rawValue, for: indexPath) as? PaymentHistoryTableViewCell
        else { return UITableViewCell() }
        switch vcState {
        
        case .normal:
            let data = self.interactor.paymentHistoryData[indexPath.row]
            cell.setupCell(by: data)

        case .searched(let paymentHistoryData):
            let data = paymentHistoryData[indexPath.row]
            cell.setupCell(by: data)
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rectOfCell = tableView.rectForRow(at: indexPath)
        let rectOfCellInSuperview = tableView.convert(rectOfCell, to: tableView.superview)
        guard let cell = tableView.cellForRow(at: indexPath) as? PaymentHistoryTableViewCell else { return }
        self.showPaymentHistoryDetailView(for: rectOfCellInSuperview, and: cell.paymentHistoryData)
    }
    
}

//MARK: - UISearchBarDelegate
extension PaymentHistoryViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText != "" else {
            self.vcState = .normal
            self.tableView.reloadData()
            return
        }
        
        vcState = .searched(interactor.paymentHistoryData.filter {
            String($0.paid).contains(searchText)
        })
        self.tableView.reloadData()
    }
}
