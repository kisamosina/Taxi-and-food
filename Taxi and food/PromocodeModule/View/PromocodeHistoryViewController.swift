//
//  PromocodeHistoryViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol PromocodeHistoryViewProtocol: class {
    var interactor: PromocodeHistoryInteractorProtocol! { get set }
    func showData()
}

class PromocodeHistoryViewController: UIViewController {
    
    var interactor: PromocodeHistoryInteractorProtocol!
    
    //MARK: - IBOutlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = PromocodeHistoryInteractor(view: self)
        self.tableViewSetup()
        self.setupUIUnits()
    }
    
    //MARK:- IBAction
    
    @IBAction func segmentSwitched(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            interactor.vcState = .active
            self.warningLabel.isHidden = false
        }
        else {
            self.interactor.vcState = .expired
            self.warningLabel.isHidden = true
            
        }
        self.tableView.reloadData()
        
    }
    
    //MARK: - Methods
    
    private func tableViewSetup() {
        let nib = UINib(nibName: PromocodeHistoryCellViewIds.nameAndReuseId.rawValue,
                        bundle: nil)
        self.tableView.register(nib,
                                forCellReuseIdentifier: PromocodeHistoryCellViewIds.nameAndReuseId.rawValue)
        self.tableView.tableFooterView = UIView()
    }
    
    private func setupUIUnits() {
        self.navigationItem.title = PromocodeHistoryViewControllerTexts.vcTitle
        self.segmentedControl.setTitle(PromocodeHistoryViewControllerTexts.segmentControlZeroTitle, forSegmentAt: 0)
        self.segmentedControl.setTitle(PromocodeHistoryViewControllerTexts.segmentControlFirstTitle, forSegmentAt: 1)
        self.warningLabel.text = PromocodeHistoryViewControllerTexts.warningLabelText
        
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension PromocodeHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch interactor.vcState {
        
        case .active:
            return interactor.activePromocodes.count
        case .expired:
            return interactor.expiredPromocodes.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PromocodeHistoryCellViewIds.nameAndReuseId.rawValue,
                                                       for: indexPath) as? PromocodeHistoryTableViewCell
        else {
            return UITableViewCell()
        }
        
        switch interactor.vcState {
        
        case .active:
            cell.setupCell(with: interactor.activePromocodes[indexPath.row], vcState: interactor.vcState)
        case .expired:
            cell.setupCell(with: interactor.expiredPromocodes[indexPath.row], vcState: interactor.vcState)
        }
        
        return cell
    }
    
    
}

extension PromocodeHistoryViewController: PromocodeHistoryViewProtocol {
    func showData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
