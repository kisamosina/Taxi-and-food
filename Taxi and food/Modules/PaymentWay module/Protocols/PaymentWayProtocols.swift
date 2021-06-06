//
//  PaymentWayProtocols.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 06.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PaymentWayViewProtocol: AnyObject {
    
    var interactor: PaymentWayInteractorProtocol! { get set }
    
    func hideLinkACardButton()
    
    func reloadTableView()
    
    func showPointsData(_ pointsData: PointsResponseData)
}

protocol PaymentWayInteractorProtocol: AnyObject {
    
    var view: PaymentWayViewProtocol! { get }
    
    var tableViewModel: PaymentWayTableViewModel! { get set }
    
    init (view: PaymentWayViewProtocol, data: [PaymentCardResponseData])
    
    func getPaymentData()
    
    func setActiveTableViewModelCell(id: Int?, title: String)
    
    func showActiveCell()
    
    func getPoints()
}
