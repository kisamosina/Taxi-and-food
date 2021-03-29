//
//  OrderHistotyInteractor.swift
//  Taxi and food
//
//  Created by mac on 25/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol OrderHistotyInteractorProtocol: class {
    
    var view: OrderHistoryViewProtocol! { get }
    
    var orderDoneHistoryData: [OrderHistoryResponseData] { get set }
    var orderCanceledHistoryData: [OrderHistoryResponseData] { get set }
    
    var vcState: OrderHistoryViewControllerStates! { get set }
    

    init(view: OrderHistoryViewProtocol)
    
}

class OrderHistotyInteractor: OrderHistotyInteractorProtocol {

    var orderDoneHistoryData: [OrderHistoryResponseData] = []
    var orderCanceledHistoryData: [OrderHistoryResponseData] = []
    
    var vcState: OrderHistoryViewControllerStates! = .done

    internal weak var view: OrderHistoryViewProtocol!
    
    required init(view: OrderHistoryViewProtocol) {
        self.view = view
        self.loadDoneOrders()
        self.loadCanceledOrders()

    }
    
    func loadDoneOrders() {
        let id = 2
        let type = "all"
        let status = "done"
           

        let resource = Resource<OrderHistoryResponse>(path: OrderRequestPaths.history.rawValue.getServerPath(for: id, and: type, and: status),
        requestType: .GET)


        NetworkService.shared.makeRequest(for: resource, completion:  { [weak self] result in

                    guard let self = self else { return }

                    switch result {

                    case .success(let response):
                        self.orderDoneHistoryData = response.data
                        self.view.configureViewElements()
                        self.view.refreshTableView()

                    case .failure(let error):
                        print(error)
                    }
                })
    }
    
    func loadCanceledOrders() {
        
        let id = 2
        let type = "all"
        let status = "canceled"
           

        let resource = Resource<OrderHistoryResponse>(path: OrderRequestPaths.history.rawValue.getServerPath(for: id, and: type, and: status),
        requestType: .GET)

        NetworkService.shared.makeRequest(for: resource, completion:  { [weak self] result in

                    guard let self = self else { return }

                    switch result {

                    case .success(let response):
                        self.orderCanceledHistoryData = response.data
                        self.view.configureViewElements()
                        self.view.refreshTableView()

                    case .failure(let error):
                        print(error)
                    }
                })
        
    }
   
}
