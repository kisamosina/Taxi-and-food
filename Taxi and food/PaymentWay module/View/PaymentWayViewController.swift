//
//  PaymentViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 06.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PaymentWayViewController: UIViewController {
    
    //MARK: - Properties
    
    internal var interactor: PaymentWayInteractorProtocol!

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var linkACardButton: MainBottomButton!
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = PaymentWayTexts.vcTitle
        self.setupTableView()
        self.setuplinkACardButton()
        
    }
    
    //MARK: - IBActions
    
    @IBAction func linkACardButtonTapped(_ sender: UIButton) {
        self.performSegueToNewCardEnterViewController()
    }
    
    //MARK: - Methods
    
    private func setupTableView() {
        self.tableView.tableFooterView = UIView()
    }
    
    private func setuplinkACardButton () {
        self.linkACardButton.setupAs(.linkACard)
    }
    
    private func performSegueToNewCardEnterViewController() {
        let vc = self.getViewController(storyboardId: StoryBoards.PaymentWay.rawValue, viewControllerId: ViewControllers.NewCardEnterViewController.rawValue)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func initPaymentWayInteractor(with data: [PaymentCardResponseData]) {
        self.interactor = PaymentWayInteractor(view: self, data: data)
    }
}

//MARK: - PaymentWayViewProtocol

extension PaymentWayViewController: PaymentWayViewProtocol { }

//MARK: - UITableViewDelegate, UITableViewDataSource

extension PaymentWayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.interactor.tableViewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor.tableViewModel.sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PaymentWayStringData.paymentWayCellReuseId.rawValue, for: indexPath) as? PaymentWayCell else { return UITableViewCell() }
        
        let cellModel = self.interactor.tableViewModel.sections[indexPath.section].cells[indexPath.row]
        
        cell.setupCell(for: cellModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PaymentWayCell else { return }
        
        switch cell.titleLabel.text {
        
        case PaymentWayTexts.bankCard, PaymentWayTexts.addCard:
            self.performSegueToNewCardEnterViewController()
        
        default:
            break
        }
        
    }
    
}
