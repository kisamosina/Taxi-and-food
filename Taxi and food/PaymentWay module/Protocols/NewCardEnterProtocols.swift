//
//  NewCardEnterProtocols.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 09.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation


protocol NewCardEnterViewProtocol: AnyObject {
    var interactor: NewCardEnterInteractorProtocol! { get set }
    func callApproveView(cardNumber: String)
    func backToPaymentWayViewController()
}


protocol NewCardEnterInteractorProtocol: AnyObject {
    
    var view: NewCardEnterViewProtocol! { get }
    
    init(view: NewCardEnterViewProtocol)
    
    func makeRequestFor(cardNumber: String, expirationDate: String, cvc: String)
    
    func makeCardApproveRequest()
}
