//
//  NetworkDataCoder.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 22.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

final class NetworkDataFetcher {
    
    static let shared = NetworkDataFetcher()
    
    private let networkService = NetworkServiceV2.shared
    
    var isLoggingOn = true
        
    private init() {}
    
    typealias FetchResult<ResponseModel: Decodable> = (Result<ResponseModel?, Error>) -> Void
    
    func fetchNetworkData<RequestModel: Codable, ResponseModel: Decodable>(resource: ResourceAPIV2,
                          requestMethod: RequestMethodV2 = .get,
                          responseModelType: ResponseModel.Type,
                          requestData: RequestModel,
                          completion: @escaping FetchResult<ResponseModel>) {
        
        var data: Data?
        
        if requestData is EmptyRequestModel {
            data = nil
        } else {
            data = encode(requestData)
        }
        
        networkService.makeRequest(resource: resource, requestMethod: requestMethod, requestData: data) {[weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let data):
                let decodedData = self.decodeFromData(type: ResponseModel.self, data: data)
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //ENCODING DATA

    private func encode<RequestModel: Codable>(_ model: RequestModel) -> Data? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase

        do {
            let jsonData = try encoder.encode(model)
            if isLoggingOn { print("JSON ENCODED DATA:\n", String(data: jsonData, encoding: .utf8) ?? "No body data encoded") }
            return jsonData
        } catch  {
            print("***********************************\n ERROR WHILE ENCODING DATA: \(error.localizedDescription) \n***********************************")
            return nil
        }
    }

    //DECODING DATA

    private func decode<ResponseModel: Decodable>(type: ResponseModel.Type, data: Data?) -> ResponseModel? {
        guard let data = data else {
            print("***********************************\nERROR: NO DATA TO DECODE\n***********************************")
            return nil
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let result = try decoder.decode(ResponseModel.self, from: data)
            return result
        } catch {
            print("***********************************\nERROR: WHILE DECODING DATA:\n\(error.localizedDescription)\n ***********************************")
            return nil
        }
    }
    
    private func decodeFromData<ResponseModel: Decodable>(type: ResponseModel.Type, data: Data?) -> ResponseModel? {
        guard let data = data else {
            print("***********************************\nERROR: NO DATA TO DECODE\n***********************************")
            return nil
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let decodedData = try decoder.decode([String: ResponseModel].self, from: data)
            return decodedData["data"]
        } catch {
            print("***********************************\nERROR: WHILE DECODING DATA:\n\(error.localizedDescription)\n ***********************************")
            return nil
        }
    }

}
