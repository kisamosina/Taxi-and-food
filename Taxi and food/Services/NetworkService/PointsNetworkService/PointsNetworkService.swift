//
//  PointsNetworkService.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 05.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

class PointsNetworkService: PointsNetworkServiceProtocol {
    
    static let shared = PointsNetworkService()
    
    private init(){}
    
    func getPoints(completion: @escaping ((Result<PointsResponseData, Error>) -> Void)) {
        guard let userData = PersistanceStoreManager.shared.getUserData(), let userId = userData.first?.id else { return }
        
        let resource = Resource<PointsResponse>(path: PaymentRequestPaths.points.rawValue.getServerPath(for: Int(userId)), requestType: .GET)
        
        NetworkService.shared.makeRequest(for: resource, completion:  {  pointsResponse in
            switch pointsResponse {
            
            case .success(let points):
                completion(.success(points.data))
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
