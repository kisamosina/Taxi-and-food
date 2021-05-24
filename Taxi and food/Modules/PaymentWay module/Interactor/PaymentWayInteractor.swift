//
//  PaymentWayInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 06.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

class PaymentWayInteractor: PaymentWayInteractorProtocol {
    
    //MARK: - Properties
    
    internal weak var view: PaymentWayViewProtocol!
    
    var isInitial: Bool = true
    
    var tableViewModel: PaymentWayTableViewModel!
            
    private var paymentCards: [PaymentCardResponseData]
    
    //MARK: - Initializer
    
    required init(view: PaymentWayViewProtocol, data: [PaymentCardResponseData]) {
        self.view = view
        self.paymentCards = data
        self.setTableViewModel()
        self.showActiveCell()
    }
    
    //MARK: - Methods
    
    // Set tableViewModel
    
    private func setTableViewModel() {
        if paymentCards.isEmpty {
            self.tableViewModel = self.generateInitialTableViewData()
        } else {
            
            self.view.hideLinkACardButton()
            self.tableViewModel = self.generateTableViewDataWithNetworkData()
        }

    }
    
    // Generate initial table view data when bank card doesn't added
    
    private func generateInitialTableViewData() -> PaymentWayTableViewModel {
        
        let cellsForFirstSection = PaymentWayTexts.initialTableViewTitles
            .filter{ $0 != PaymentWayTexts.points }
            .compactMap {[unowned self] in return self.getInitialPaymentWayTableViewCellModel(for: $0)}
        
        let cellsForSecondSection = PaymentWayTexts.initialTableViewTitles
            .filter{ $0 == PaymentWayTexts.points }
            .compactMap {[unowned self] in return self.getInitialPaymentWayTableViewCellModel(for: $0)}
        
        let sectionOne = PaymentWayTableViewSectionModel(cells: cellsForFirstSection)
        let sectionTwo = PaymentWayTableViewSectionModel(cells: cellsForSecondSection)
        
        return PaymentWayTableViewModel(sections: [sectionOne, sectionTwo])
    }
    
    
    // Get PaymentWayTableViewCellModel
    
    private func getInitialPaymentWayTableViewCellModel(for title: String) -> PaymentWayTableViewCellModel? {
        
        switch title {
        
        case PaymentWayTexts.cash:
            return PaymentWayTableViewCellModel(checkMark: .active, title: title, iconName: CustomImagesNames.paymentWayCash.rawValue)
        case PaymentWayTexts.bankCard:
            return PaymentWayTableViewCellModel(checkMark: .enter, title: title, iconName: CustomImagesNames.paymentWayOne.rawValue)
        case PaymentWayTexts.applePay:
            return PaymentWayTableViewCellModel(checkMark: .inactive, title: title, iconName: CustomImagesNames.paymentWayApple.rawValue)
        case PaymentWayTexts.points:
            return PaymentWayTableViewCellModel(checkMark: .enter, title: title, iconName: CustomImagesNames.paymentWayPoints.rawValue)
        case PaymentWayTexts.addCard:
            return PaymentWayTableViewCellModel(checkMark: .enter, title: title, iconName: nil )
        
        default:
            return nil
        }
        
    }
    
    // Get table view data when cards added
    
    private func generateTableViewDataWithNetworkData() -> PaymentWayTableViewModel {
        
        var cellsForFirstSection = PaymentWayTexts.initialTableViewTitles
            .filter{ $0 != PaymentWayTexts.points && $0 != PaymentWayTexts.bankCard }
            .compactMap {[unowned self] in return self.getInitialPaymentWayTableViewCellModel(for: $0)}
        
        self.paymentCards.forEach {
            let paymentWayTableViewCellModel = PaymentWayTableViewCellModel(checkMark: .inactive, title: PaymentWayTexts.cardTitle + $0.hidedNumber, iconName: CustomImagesNames.visaIcon.rawValue)
            cellsForFirstSection.insert(paymentWayTableViewCellModel, at: 1)
        }
        
        let cellsForSecondSection = [self.getInitialPaymentWayTableViewCellModel(for: PaymentWayTexts.addCard)].compactMap { $0 } + PaymentWayTexts.initialTableViewTitles
            .filter{ $0 == PaymentWayTexts.points }
            .compactMap {[unowned self] in return self.getInitialPaymentWayTableViewCellModel(for: $0)}
        
        let sectionOne = PaymentWayTableViewSectionModel(cells: cellsForFirstSection)
        let sectionTwo = PaymentWayTableViewSectionModel(cells: cellsForSecondSection)
        
        return PaymentWayTableViewModel(sections: [sectionOne, sectionTwo])
    }
    
    // Get cards data from server
    
    func getPaymentData() {
        guard let userData = PersistanceStoreManager.shared.getUserData(), let userId = userData.first?.id else { return }
        
        let resource = Resource<PaymentResponse>(path: PaymentRequestPaths.paymentCards.rawValue.getServerPath(for: Int(userId)), requestType: .GET)
        NetworkService.shared.makeRequest(for: resource, completion:  {[weak self] paymentResponse in
            guard let self = self else { return }
            
            switch paymentResponse {
            
            case .success(let paymentResponse):
                self.paymentCards = paymentResponse.data
                self.setTableViewModel()
                self.showActiveCell()
            case .failure(let error):
                
                print(error.localizedDescription)
            }
        })
    }
    
    // Set active cells
    
    func setActiveTableViewModelCell(_ title: String) {
        
        guard title != PaymentWayTexts.bankCard,
              title != PaymentWayTexts.addCard,
              title != PaymentWayTexts.points
        
        else { return }
        
        if PersistanceStoreManager.shared.getSavedPaymentWay()?.first?.title != title {
            self.savePaymentWay(title)
        }
        
        var cells: [PaymentWayTableViewCellModel] = []
        
        for cell in self.tableViewModel.sections[0].cells {
            
            var newCell: PaymentWayTableViewCellModel
            
            if cell.title == title {
                newCell = PaymentWayTableViewCellModel(checkMark: .active, title: cell.title, iconName: cell.iconName)
            } else {
                newCell = PaymentWayTableViewCellModel(checkMark: .inactive, title: cell.title, iconName: cell.iconName)
            }
            
            cells.append(newCell)
        }
        self.tableViewModel.sections[0].cells = cells
        self.view.reloadTableView()
    }
    
    private func savePaymentWay(_ title: String) {
        PersistanceStoreManager.shared.savePaymentWay(title)
    }
    
    func showActiveCell() {

        if let title = PersistanceStoreManager.shared.getSavedPaymentWay()?.first?.title {
            self.setActiveTableViewModelCell(title)
        }
    }
    
    func getPoints() {
        
        guard let userData = PersistanceStoreManager.shared.getUserData(), let userId = userData.first?.id else { return }
        
        let resource = Resource<PointsResponse>(path: PaymentRequestPaths.points.rawValue.getServerPath(for: Int(userId)), requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource, completion:  {  pointsResponse in
            switch pointsResponse {
            
            case .success(let points):
                self.view.showPointsData(points.data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
}
