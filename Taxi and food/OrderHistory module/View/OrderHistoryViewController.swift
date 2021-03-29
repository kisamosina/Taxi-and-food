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
    
    func refreshTableView()
    
   
    
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
        self.segmentedControl.addTarget(self, action: #selector(handleSegmentControlChange), for: .valueChanged)
        self.configureUI()
        self.setupTableView()

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
    
    @objc private func handleSegmentControlChange() {
       
         if segmentedControl.selectedSegmentIndex == 0 {
            interactor.vcState = .done
         } else {
            interactor.vcState = .canceled
        }
       
        self.tableView.reloadData()
            
        }

    }



//MARK: - OrderHistoryViewProtocol extension

extension OrderHistoryViewController: OrderHistoryViewProtocol {

    func configureViewElements() {
        
        DispatchQueue.main.async {
            self.tableView.isHidden = self.interactor.orderDoneHistoryData.isEmpty
            self.segmentedControl.isHidden = self.interactor.orderDoneHistoryData.isEmpty
            self.backgroundImageView.isHidden = !self.interactor.orderDoneHistoryData.isEmpty
            self.emptyLabel.isHidden = !self.interactor.orderDoneHistoryData.isEmpty
            
            if !self.interactor.orderDoneHistoryData.isEmpty {
                self.tableView.reloadData()
            }
        }
        
    }
}

extension OrderHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch interactor.vcState {
        case .done:
            return interactor.orderDoneHistoryData.count
        case .canceled:
            return interactor.orderCanceledHistoryData.count
        case .none:
            return 0
        }
          
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderHistoryIds.id.rawValue, for: indexPath) as? OrderHistoryTableViewCell
        else { return UITableViewCell() }
        
        switch interactor.vcState {
        case .done:
            cell.setUpCell(by: interactor.orderDoneHistoryData[indexPath.row])
        case .canceled:
            cell.setUpCell(by: interactor.orderCanceledHistoryData[indexPath.row])
        case .none:
            break
        
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rectOfCell = tableView.rectForRow(at: indexPath)
        let rectOfCellInSuperview = tableView.convert(rectOfCell, to: tableView.superview)
        guard let cell = tableView.cellForRow(at: indexPath) as? OrderHistoryTableViewCell else {
            return
        }
        guard let vc = self.getViewController(storyboardId: StoryBoards.Inactive.rawValue, viewControllerId: ViewControllers.InactiveViewController.rawValue) as? InactiveViewController else {
            return
        }
        vc.setCellRectAndDetailViewOrderData(rect: rectOfCellInSuperview, data: cell.orderHistoryData)
        self.present(vc, animated: false)
        
    }
 
}

extension OrderHistoryViewController {
    
    func refreshTableView() {

    DispatchQueue.main.async {
        self.tableView.reloadData()
    }
}

}


