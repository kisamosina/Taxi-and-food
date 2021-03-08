//
//  PaymentWayInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 06.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

class PaymentWayInteractor: PaymentWayInteractorProtocol {
    
    internal weak var view: PaymentWayViewProtocol!
    
    var isInitial: Bool = true
    
    var tableViewModel: PaymentWayTableViewModel!
    
    private var cardData: [PaymentCardResponseData]
    
    required init(view: PaymentWayViewProtocol, data: [PaymentCardResponseData]) {
        self.view = view
        self.cardData = data
        self.tableViewModel = self.generateInitialTableViewData()
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
        case PaymentWayTexts.bankCard:
            return PaymentWayTableViewCellModel(checkMark: .enter, title: title, iconName: nil )
        
        default:
            return nil
        }
        
    }
    
}
