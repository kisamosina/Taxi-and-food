//
//  PaymentWayNetworkService.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

class PaymentWayNetworkService: PaymentWayNetworkServiceProtocol {
    
    static let shared: PaymentWayNetworkService = PaymentWayNetworkService()
    
    private var resource: ResourceAPIV2?
    
    typealias PaymentCardsRequstResult = (Result<[PaymentCardResponseData], Error>) -> Void
    
    private init() {
        
        let userData = PersistanceStoreManager.shared.getUserData()
        if let userId32 = userData?.first?.id {
            let userId = Int(userId32)
            let path = PaymentRequestPaths.paymentCardsV2.rawValue.getServerPath(for: userId)
            self.resource = ResourceAPIV2(path: path)
        }
    }
        
    func getPaymentWayData(completion: @escaping PaymentCardsRequstResult ) {
        guard let resource = resource else { return }
        NetworkDataFetcher.shared.fetchNetworkData(resource: resource,
                                                   responseModelType: PaymentResponse.self,
                                                   requestData: EmptyRequestModel()) { result in
            switch result {
                
            case .success(let decodedData):
                guard let decodedData = decodedData else { return }
                completion(.success(decodedData.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
