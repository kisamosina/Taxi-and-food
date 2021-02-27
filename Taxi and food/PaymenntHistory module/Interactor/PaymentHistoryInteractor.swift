//
//  PaymentHistoryInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 27.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PaymentHistoryInteractorProtocol: class {
    
    var view: PaymentHistoryViewProtocol! { get }
    var isPaymentLoad: Bool { get set }
    var paymentHistotyData: [PaymentsHistoryResponseData] { get set }
    
    init(view: PaymentHistoryViewProtocol)
    
    func loadPayments()
}

class PaymentHistoryInteractor: PaymentHistoryInteractorProtocol {
        
    
    internal weak var view: PaymentHistoryViewProtocol!
    
    var isPaymentLoad: Bool = false
    
    var paymentHistotyData: [PaymentsHistoryResponseData] = []

    
    required init(view: PaymentHistoryViewProtocol) {
        self.view = view
        loadPayments()
    }
    
    func loadPayments() {
        
        guard let userData = PersistanceStoreManager.shared.getUserData() else {
            print("No user id in storage")
            return
        }
        
        let id = Int(userData[0].id)
        
        let resource = Resource<PaymentsHistoryResponse>(path: PaymentRequestPaths.history.rawValue.getServerPath(for: id),
                                                         requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            
            case .success(let response):
                print(response)
                self.paymentHistotyData = response.data
                self.view.setupViewElements()
            case .failure(let error):
                print(error)
            }
        }
    }
}
