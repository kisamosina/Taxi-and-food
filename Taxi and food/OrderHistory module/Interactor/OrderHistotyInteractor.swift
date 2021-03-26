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
    var orderHistoryData: [OrderHistoryResponseData] { get set }
    var orderStatus: String! { get set }
    
    init(view: OrderHistoryViewProtocol)
}

class OrderHistotyInteractor: OrderHistotyInteractorProtocol {
    var orderHistoryData: [OrderHistoryResponseData] = []
    
    var orderStatus: String! = "canceled"
    
    
    internal weak var view: OrderHistoryViewProtocol!
    
    required init(view: OrderHistoryViewProtocol) {
        self.view = view
        loadOrders()
    }
    
    func loadOrders() {
        
        print("want to load")
        
        //        guard let userData = PersistanceStoreManager.shared.getUserData() else {
        //            print("No user id in storage")
        //            return
        //        }
                
//                let id = Int(userData[0].id)
        let id = 2
        let type = "all"
//        let status = "done"
        
        switch OrderStatusType.getOrderStatusType(from: orderStatus) {
        case .done:
            self.orderStatus = "done"
        case .canceled:
            self.orderStatus = "canceled"
        case .unknown:
            self.orderStatus = "done"
            
        }
        let resource = Resource<OrderHistoryResponse>(path: OrderRequestPaths.history.rawValue.getServerPath(for: id, and: type, and: orderStatus),
        requestType: .GET)
        print("resource")
        print(resource)

        NetworkService.shared.makeRequest(for: resource, completion:  { [weak self] result in

                    guard let self = self else { return }

                    switch result {

                    case .success(let response):
                        self.orderHistoryData = response.data
                        self.view.configureViewElements()
                        print("here is my data")
                    case .failure(let error):
                        print(error)
                    }
                })
    }
   
}
