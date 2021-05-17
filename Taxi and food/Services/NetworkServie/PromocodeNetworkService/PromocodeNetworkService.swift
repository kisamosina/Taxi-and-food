//
//  PromocodeNetworkService.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 05.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

class PromocodeNetworkService: PromocodeNetworkServiceProtocol {
    
    static let shared = PromocodeNetworkService()
    
    private init() {}
    
    func requestPromocodeActivate(code: String, completion: @escaping(Result<PromocodeDataResponse, Error>) -> Void) {
        guard let id = PersistanceStoreManager.shared.getUserData()?[0].id
        else {
            print("No user id in storage")
            return
            
        }
        
        let promocodeResource = Resource<PromocodeResponse>(path: PromocodesRequestPaths.activate.rawValue.getServerPath(for: Int(id)),
                                                          requestType: .POST,
                                                          requestData: [PromocodesRequestKeys.code.rawValue: code])

        NetworkService.shared.makeRequest(for: promocodeResource) { result in
        
            switch result {
            
            case .success(let promocodeResponse):
                completion(.success(promocodeResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
