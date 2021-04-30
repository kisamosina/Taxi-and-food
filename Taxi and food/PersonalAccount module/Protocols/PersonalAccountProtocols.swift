//
//  PersonalAccountProtocols.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 04.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PersonalAccountViewProtocol: AnyObject {
    var interactor: PersonalAccountInteractorProtocol! { get set }
    
    func reloadTableViewData()
}

protocol PersonalAccountInteractorProtocol: AnyObject {
    
    var view: PersonalAccountViewProtocol! { get }
    
    var personalAccountTableViewData: [PersonalAccountTableViewModel]! { get set }
    var paymentCards: [PaymentCardResponseData] { get set }
    
    init (view: PersonalAccountViewProtocol)
    
    func getPaymentData()
}
