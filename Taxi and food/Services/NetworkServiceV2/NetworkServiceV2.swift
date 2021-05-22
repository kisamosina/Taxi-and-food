//
//  NetworkServiceV2.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 22.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

final class NetworkServiceV2 {

    static let shared = NetworkServiceV2()
    
    var isLoggingOn = true
    
    typealias FetchResult = (Result<Data?, Error>) -> Void
    
    private init() {}
    
    func makeRequest(resource: ResourceAPIV2,
                     requestMethod: RequestMethodV2 = .get,
                     requestData: Data? = nil,
                     completion: @escaping FetchResult) {
        
        switch requestMethod {
            
        case .get:
            performGetRequest(resource: resource, completion: completion)
        case .post:
            guard let requestData = requestData else {
                print("***********************************\n ERROR: Request data not specified\n***********************************")
                return
            }
            performPostRequest(resource: resource, requestData: requestData, completion: completion)
        case .put:
            guard let requestData = requestData else {
                print("***********************************\n ERROR: Request data not specified\n***********************************")
                return
            }
            performPostRequest(requestMethod: .put, resource: resource, requestData: requestData, completion: completion)
        case .delete:
            guard let requestData = requestData else {
                print("***********************************\n ERROR: Request data not specified\n***********************************")
                return
            }
            performPostRequest(requestMethod: .delete, resource: resource, requestData: requestData, completion: completion)
        }
        
    }
    
    //POST REQUEST
    
    private func performPostRequest(requestMethod: RequestMethodV2 = .post,
                                    resource: ResourceAPIV2,
                                    requestData: Data,
                                    completion: @escaping FetchResult) {
        
        guard let url = resource.urlComponents.url else {
            print("***********************************\n ERROR: Invalid URL\n***********************************" )
            return
        }
        
        guard requestMethod != .get else { return }
        
        //Config request
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod.rawValue
        
        if !resource.header.isEmpty {
            for (key, value) in resource.header {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestData
        if isLoggingOn { print("JSON \(requestMethod.rawValue) REQUEST, REQUEST DATA: ", String(data: request.httpBody!, encoding: .utf8) ?? "No request body data!!!") }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) {[isLoggingOn] data, response, error in
            // check for any errors
            
            guard error == nil else {
                print("***********************************\n \(requestMethod.rawValue) REQUEST ERROR: \(error!.localizedDescription)\n***********************************" )
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            guard (200...299).contains(httpResponse.statusCode)
            else {
                print("Server error code: \(httpResponse.statusCode)")
                let error = ServerErrors(statusCode: httpResponse.statusCode)
                completion(.failure(error))
                return
            }
            
            
            //Success response
            print("HTTP \(requestMethod.rawValue) REQUEST SUCCESFULL. RETURN CODE: " + String(httpResponse.statusCode))
            if isLoggingOn, let data = data { print("JSON \(requestMethod.rawValue) REQUEST, RESPONSE DATA:\n", String(data: data, encoding: .utf8) ?? "NO BODY DATA") }
            completion(.success(data))
        }
        
        task.resume()
    }
    
    //GET REQUEST
    
    private func performGetRequest(resource: ResourceAPIV2, completion: @escaping FetchResult) {
        
        guard let url = resource.urlComponents.url else {
            print("***********************************\n ERROR: Invalid URL\n***********************************" )
            return
        }
        
        //Config request
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethodV2.get.rawValue
        
        if !resource.header.isEmpty {
            for (key, value) in resource.header {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { [isLoggingOn] data, response, error in
            
            if let response = response as? HTTPURLResponse {
                print("HTTP GET REQUEST SUCCESFULL. RETURN CODE: " + String(response.statusCode))
            }
            
            if let data = data {
                if isLoggingOn { print("JSON GET REQUEST, RESPONSE DATA:\n", String(data: data, encoding: .utf8) ?? "no body data") }
                completion(.success(data))
            } else if let error = error {
                print("***********************************\n GET REQUEST ERROR: \(error.localizedDescription) \n***********************************")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
}
