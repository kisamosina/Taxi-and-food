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
    
    func hideLinkACardButton()
    
    func reloadTableView()
    
    func showPointsData(_ pointsData: PointsResponseData)
}

protocol PaymentWayInteractorProtocol: class {
    
    var view: PaymentWayViewProtocol! { get }
    
    var tableViewModel: PaymentWayTableViewModel! { get set }
    
    init (view: PaymentWayViewProtocol, data: [PaymentCardResponseData])
    
    func getPaymentData()
    
    func setActiveTableViewModelCell(_ title: String)
    
    func showActiveCell()
    
    func getPoints()
}
