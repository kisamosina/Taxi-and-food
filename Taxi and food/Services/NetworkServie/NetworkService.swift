//
//  NetworkService.swift
//  Taxi and food
//
//  Created by mac on 12/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    typealias FetchResult<T:Decodable> = (Result<T, Error>) -> Void
    
    //Make networking requests
    func makeRequest<T,U>(for resource: Resource<T>, data: U? = nil, completion: @escaping FetchResult<T>) where U: Codable {
        
        switch resource.requestMethod {
            
        case .GET:
            self.getData(from: resource, completion: completion)
        case .POST:
            guard let data = data else { return }
            self.postData(to: resource, data: data, completion: completion)
        }
        
    }
        
    //WHEN GET REQUEST
    private func loadData(from url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                print("ERROR while downloading data: \(error.localizedDescription)")
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    //DECODE DATA
    private func getData <T:Decodable>(from resource: Resource<T>, completion: @escaping FetchResult<T>) {
        
        guard let url = resource.urlComponents.url else { return }
        
        self.loadData(from: url) { result in
            
            switch result {
            
            case .success(let data):
                
                let decodeResult = self.decode(for: resource, data: data)
                completion(decodeResult)
                                
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
    }
    
    //WHEN POST REQUEST
    private func postData <T,U> (to resource: Resource<T>, data: U, completion: @escaping FetchResult<T>) where U: Codable {
    
        guard let url = resource.urlComponents.url else { return }
        
        var request = URLRequest (url: url)
        request.httpMethod = resource.requestMethod.rawValue
        
        let encodedResult = self.encode(data: data)
        
        switch encodedResult {
        
        case .success(let httpBody):
            request.httpBody = httpBody
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        case .failure(let error):
            print("CATCHED ERROR WHILE ENCODING DATA: \(error.localizedDescription)" )
            return
        }
        
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // check for any errors
            guard error == nil else {
                print("error calling POST on (url)")
                print(error!)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Server error code: \(httpResponse.statusCode)")
                return
            }
            // Success response
            print("HTTP Post successful. Return code: " + String(httpResponse.statusCode))
            if let mimeType = httpResponse.mimeType /*, mimeType == "application/json"*/ {
                print("MimeType: " + mimeType)
            }
            guard let data = data else { return }
            let result = self.decode(for: resource, data: data)
            completion(result)
        }
        
        task.resume()
    }
    
    //ENCODING DATA
    private func encode<T: Codable>(data: T) -> Result<Data, Error> {
        
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(data)
            return .success(jsonData)
        } catch {
            return .failure(error)
        }
    }
    
    //DECODING DATA
    
    private func decode<T: Decodable>(for resource: Resource<T>, data: Data) -> Result<T, Error> {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let result = try decoder.decode(T.self, from: data)
            return .success(result)
            
        } catch {
            return .failure(error)
            
        }
    }
    
}

