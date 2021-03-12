//
//  PaymentWayProtocols.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 06.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PaymentWayViewProtocol: class {
    var interactor: PaymentWayInteractorProtocol! { get set }
}

protocol PaymentWayInteractorProtocol: class {
    
    var view: PaymentWayViewProtocol! { get }
    
    var isInitial: Bool { get set }
    
    var tableViewModel: PaymentWayTableViewModel { get }
    
    init (view: PaymentWayViewProtocol, data: [PaymentCardResponseData])
}
