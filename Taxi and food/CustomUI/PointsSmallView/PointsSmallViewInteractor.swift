//
//  PointsSmallViewInteractor.swift
//  Taxi and food
//
//  Created by mac on 20/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol PointsSmallViewInteractorProtocol: class {
    
    var view: PointsSmallViewProtocol! { get }
    
    func getPoints()
}

class PointsSmallViewInteractor: PointsSmallViewInteractorProtocol {
    
    //MARK: - Initializer
    
    required init(view: PointsSmallViewProtocol) {
        self.view = view
    }
    
    var view: PointsSmallViewProtocol!
    
    func getPoints() {
        
        let userId = 3
        
//        guard let userData = PersistanceStoreManager.shared.getUserData(), let userId = userData.first?.id else { return }
        
        let resource = Resource<PointsResponse>(path: PaymentRequestPaths.points.rawValue.getServerPath(for: Int(userId)), requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource, completion:  {  pointsResponse in
            switch pointsResponse {
            
            case .success(let points):
                self.view.setupPoints(points.data)
//                self.view.updateData()
                print("success and ready to show points")
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    
    
}


