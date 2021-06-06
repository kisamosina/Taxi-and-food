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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.interactor.getPaymentData()
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
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

extension PaymentWayViewController: PaymentWayViewProtocol {
    
    func showPointsData(_ pointsData: PointsResponseData) {
        DispatchQueue.main.async {
            guard let vc  = self.getViewController(storyboardId: StoryBoards.Inactive.rawValue, viewControllerId: ViewControllers.InactiveViewController.rawValue) as? InactiveViewController
            else { return }
            
            vc.setState(.showPointsView(pointsData))
            vc.delegate = self
            
            self.present(vc, animated: false)
        }
    }
    
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func hideLinkACardButton() {
        DispatchQueue.main.async {
            self.linkACardButton.isHidden = true
        }
    }
    
    
}

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
        guard let cell = tableView.cellForRow(at: indexPath) as? PaymentWayCell,
              let title = cell.titleLabel.text
        else { return }
        
        switch title {
        
        case PaymentWayTexts.bankCard, PaymentWayTexts.addCard:
            self.performSegueToNewCardEnterViewController()
            
        case PaymentWayTexts.points:
            self.interactor.getPoints()
            
        default:
            self.interactor.setActiveTableViewModelCell(id: cell.cardId, title: title)
        }
        
    }
    
}

extension PaymentWayViewController: InactiveViewControllerDelegate {
    
    func beginSavePointsButtonTapped() {
        guard let mapVC = self.navigationController?.viewControllers.first(where: { $0 is MapViewController }) else { return }
        self.navigationController?.popToViewController(mapVC, animated: true)
    }
}
