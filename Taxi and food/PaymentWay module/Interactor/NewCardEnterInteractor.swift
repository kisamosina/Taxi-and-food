//
//  NewCardEnterInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 09.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

class NewCardEnterInteractor: NewCardEnterInteractorProtocol {
    
    internal weak var view: NewCardEnterViewProtocol!
    
    var addedNewCardResponseData: AddNewCardResponseData!
    
    required init(view: NewCardEnterViewProtocol) {
        self.view = view
    }
    
    func makeRequestFor(cardNumber: String, expirationDate: String, cvc: String) {
        guard let user = PersistanceStoreManager.shared.getUserData()?.first else { return }
        
        let userId = user.id
        let resource = Resource<AddNewCardResponse>(path: NewPaymentCardRequestPaths.paymentCard.rawValue.getServerPath(for: Int(userId)),
                                                     requestType: .POST,
                                                     requestData:[
                                                        NewPaymentCardRequestKeys.number.rawValue: cardNumber,
                                                        NewPaymentCardRequestKeys.expiryDate.rawValue: expirationDate,
                                                        NewPaymentCardRequestKeys.cvc.rawValue: cvc
                                                        ])
        
        NetworkService.shared.makeRequest(for: resource) { result in
            
            switch result {
            
            case .success(let response):
                self.addedNewCardResponseData = response.data
                DispatchQueue.main.async {
                    self.view.callApproveView(cardNumber: self.addedNewCardResponseData.hidedNumber)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func makeCardApproveRequest() {
        
        guard let user = PersistanceStoreManager.shared.getUserData()?.first else { return }
        
        let userId = user.id
        let resource = Resource<ApproveCardResponse>(path: NewPaymentCardRequestPaths
                                                        .approveCard
                                                        .rawValue
                                                        .getServerPath(for: Int(userId),
                                                                       and: addedNewCardResponseData.id),
                                                     requestType: .POST)
                
        NetworkService.shared.makeRequest(for: resource) { result in
            
            switch result {
            
            case .success(_):
               print("SUCCESS CARD APPROVEMENT")
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
}
