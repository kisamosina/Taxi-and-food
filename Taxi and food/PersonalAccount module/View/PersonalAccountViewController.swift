//
//  PersonalAccountViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 03.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PersonalAccountViewController: UIViewController {
    
    //MARK: - Properties
    
    var interactor: PersonalAccountInteractorProtocol!
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var logOutButton: LogOutButton!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = PersonalAccountInteractor(view: self)
        self.titleLabel.text = PersonalAccountViewControllerTexts.vcTitle
        self.setupTableView()
        self.logOutButton.setTitle(PersonalAccountViewControllerTexts.logoutButtonTitle, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    //MARK: - IBActions
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        guard let vc = getViewController(storyboardId: StoryBoards.Inactive.rawValue, viewControllerId: ViewControllers.InactiveViewController.rawValue) as? InactiveViewController else { return }
        vc.setState(.showLogoutView)
        vc.delegate = self
        self.present(vc, animated: false)
    }
    
    //MARK: - Methods
    
    private func setupTableView() {
        self.tableView.tableFooterView = UIView()
    }
    
}


extension PersonalAccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor.personalAccountTableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.personalAccountTableViewData[section].cellsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonalAccountCellStringData.id.rawValue, for: indexPath) as? PersonalAccountCell else { return UITableViewCell() }
        let cellData = interactor.personalAccountTableViewData[indexPath.section].cellsData[indexPath.row]
        cell.setupCell(for: cellData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellName = self.interactor.personalAccountTableViewData[indexPath.section].cellsData[indexPath.row].name
        
        switch PersonalAccountViewControllerSegues.getCase(from: cellName) {
        
        case .PaymentHistory:
            let vc = self.getViewController(storyboardId: StoryBoards.PaymentHistory.rawValue, viewControllerId: ViewControllers.PaymentHistoryViewController.rawValue)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .PaymentWay:
            guard let vc = self.getViewController(storyboardId: StoryBoards.PaymentWay.rawValue, viewControllerId: ViewControllers.PaymentWayViewController.rawValue) as? PaymentWayViewController else { return }
            vc.initPaymentWayInteractor(with: self.interactor.paymentCards)
            self.navigationController?.pushViewController(vc, animated: true)
        case .MyAddresses:
            let vc = self.getViewController(storyboardId: StoryBoards.Addresses.rawValue, viewControllerId: ViewControllers.AddressViewController.rawValue)
            self.navigationController?.pushViewController(vc, animated: true)

        case .unknown:
            break
            
        }
    }
    
}

//MARK: - PersonalAccountViewProtocol

extension PersonalAccountViewController: PersonalAccountViewProtocol {
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension PersonalAccountViewController: InactiveViewControllerDelegate {
    
    func logOutButtonTapped() {
        
        PersistanceStoreManager.shared.deleteAllData()
        self.navigationController?.popToRootViewController(animated: true)
    }
}
