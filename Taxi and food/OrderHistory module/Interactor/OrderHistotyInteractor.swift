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
    var orderHistoryData: [OrderHistoryResponse] { get set }
    
    init(view: OrderHistoryViewProtocol)
}

class OrderHistotyInteractor: OrderHistotyInteractorProtocol {
    var orderHistoryData: [OrderHistoryResponse] = []
    
    
    internal weak var view: OrderHistoryViewProtocol!
    
    required init(view: OrderHistoryViewProtocol) {
        self.view = view
    }
    
    func loadOrders() {
        
        //        guard let userData = PersistanceStoreManager.shared.getUserData() else {
        //            print("No user id in storage")
        //            return
        //        }
                
        //        let id = Int(userData[0].id)
//                let id = 2
//                let resource = Resource<OrderHistoryResponse>(path: OrderRequestPaths.history.rawValue.getServerPath(for: id),
//                                                                 requestType: .GET)
//
//        NetworkService.shared.makeRequest(for: resource, completion:  { [weak self] result in
//
//                    guard let self = self else { return }
//
//                    switch result {
//
//                    case .success(let response):
//                        self.orderHistoryData = response.data
////                        self.view.setupViewElements()
//                    case .failure(let error):
//                        print(error)
//                    }
//                })
    }
   
}
