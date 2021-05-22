//
//  NetworkDataCoder.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 22.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

final class NetworkDataCoder {
    
    static let shared = NetworkDataCoder()
    
    var isLoggingOn = true
    
    private init() {}
    
    //ENCODING DATA

    func encode<RequestModel: Codable>(_ model: RequestModel) -> Data? {
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

    func decode<ResponseModel: Decodable>(type: ResponseModel.Type, data: Data?) -> ResponseModel? {
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
            
            return nil
        }
    }
}
