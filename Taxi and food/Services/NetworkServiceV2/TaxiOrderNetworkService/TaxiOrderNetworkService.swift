//
//  TaxiOrderNetworkService.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 25.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

class TaxiOrderNetworkService: TaxiOrderNetworkServiceProtocol {
    
    static let shared: TaxiOrderNetworkService = TaxiOrderNetworkService()
    
//    private var resource: ResourceAPIV2?
    let userId: Int?
    
    typealias PaymentCardsRequstResult = (Result<TaxiPlaceOrderResponseModel, Error>) -> Void
    
    private init() {
        
        let userData = PersistanceStoreManager.shared.getUserData()
        if let userId32 = userData?.first?.id {
            self.userId = Int(userId32)
            return
        }
        self.userId = nil
    }
    
    func makePlaceOrderRequestModel(tariff: Int, from: String, to: String, paymentCardId: Int?, paymentMethod: String, promoCodes: [String]?, credit: Int?) -> TaxiPlaceOrderRequestModel {
        return TaxiPlaceOrderRequestModel(tariff: tariff, from: from, to: to, paymentCard: paymentCardId, paymentMethod: paymentMethod, promoCodes: promoCodes, credit: credit ?? 0)
    }
    
    func makeTaxiPriceRequestModel(from: String, to: String, promoCodes: [String]? = nil, credit: Int?) -> TaxiPriceRequestModel {
        return TaxiPriceRequestModel(from: from, to: to, promoCodes: promoCodes, credit: credit)
    }

    
    func placeTaxiOrder(requestData: TaxiPlaceOrderRequestModel, completion: @escaping (Result<TaxiPlaceOrderResponseModel, Error>) -> Void) {
        guard let userId = userId else { return }
        let path = TaxiOrderRequestPaths.placeOrder.rawValue.getServerPath(for: userId)
        let resource = ResourceAPIV2(path: path)
        
        NetworkDataFetcher.shared.fetchNetworkData(resource: resource, requestMethod: .post, responseModelType: TaxiPlaceOrderResponseModel.self, requestData: requestData) { result in
            
            switch result {
                
            case .success(let responseData):
                guard let responseData = responseData else { return }
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestPrice(requestData: TaxiPriceRequestModel, completion: @escaping (Result<[TaxiPriceResponseModel], Error>) -> Void) {
        guard let userId = userId else { return }
        let path = TaxiOrderRequestPaths.requestPrice.rawValue.getServerPath(for: userId)
        let resource = ResourceAPIV2(path: path)
        
        NetworkDataFetcher.shared.fetchNetworkData(resource: resource, requestMethod: .post, responseModelType: [TaxiPriceResponseModel].self, requestData: requestData) { result in
            switch result {
                
            case .success(let responseData):
                guard let responseData = responseData else { return }
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


}
