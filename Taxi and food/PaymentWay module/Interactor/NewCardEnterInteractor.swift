//
//  NewCardEnterInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 09.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

class NewCardEnterInteractor: NewCardEnterInteractorProtocol {
    
    var view: NewCardEnterViewProtocol!
    
    required init(view: NewCardEnterViewProtocol) {
        self.view = view
    }
    
    func makeRequestFor(cardNumber: String, expirationDate: String, cvv: String) {
//        guard let user = PersistanceStoreManager.shared.getUserData()?.first else { return }
        
//        let userId = user.id
//        let resource = Resource<NewCardEnterRequest>(path: NewPaymentCardRequestPaths.paymentCard.rawValue.getServerPath(for: Int(userId)),
//                                                     requestType: .POST,
//                                                     requestData: ["data": [
//                                                        "number": cardNumber,
//                                                        "expiry_date": expirationDate,
//                                                        "status":
//                                                     ]])
    }
    
}
