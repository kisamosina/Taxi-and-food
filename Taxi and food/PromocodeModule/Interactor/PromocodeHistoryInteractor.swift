//
//  PromocodeHistoryInteractor.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

protocol PromocodeHistoryInteractorProtocol: class {
    
    var view: PromocodeHistoryViewProtocol! { get }
    var vcState: PromocodeHistoryViewControllerStates { get set }
    var expiredPromocodes: [PromocodeHistoryData] { get }
    var activePromocodes: [PromocodeHistoryData] { get }
    
    init(view: PromocodeHistoryViewProtocol)

}

class PromocodeHistoryInteractor: PromocodeHistoryInteractorProtocol {
      
    
    internal weak var view: PromocodeHistoryViewProtocol!
    
    private var promocodeHistoryData: [PromocodeHistoryData] = []
    
    var vcState: PromocodeHistoryViewControllerStates = .active
    
    var expiredPromocodes: [PromocodeHistoryData] {
        
        return promocodeHistoryData.filter{ data in
            
            let currentDate = Date()
            guard let activationDate = data.dateActivation.iso8601withFractionalSeconds else { return false }
            let timeInt = TimeInterval(data.validity)
            let expirationDate = activationDate + timeInt
            return currentDate > expirationDate
        }
    }
    
    var activePromocodes: [PromocodeHistoryData] {
        
        return promocodeHistoryData.filter{ data in
            
            let currentDate = Date()
            guard let activationDate = data.dateActivation.iso8601withFractionalSeconds else { return false }
            let timeInt = TimeInterval(data.validity)
            let expirationDate = activationDate + timeInt
            return currentDate < expirationDate
        }
    }
    
    
    
    required init(view: PromocodeHistoryViewProtocol) {
        self.view = view
        self.loadHistory()
    }
    
    private func loadHistory() {
        
        guard let userData = PersistanceStoreManager.shared.getUserData() else {
            print("No user id in storage")
            return
        }
        
        let id = Int(userData[0].id)
        let promocodeResource = Resource<PromocodeHistoryResponse>(path: PromocodesRequestPaths.getHistory.rawValue.getServerPath(for: id),
                                                          requestType: .GET)
      
        NetworkService.shared.makeRequest(for: promocodeResource) { result in
            
            switch result {
            
            case .success(let historyResponse):
                self.promocodeHistoryData = historyResponse.data
                self.view.showData()
            case .failure(let error):
                print(error)
            }
        }

    }
    
}
