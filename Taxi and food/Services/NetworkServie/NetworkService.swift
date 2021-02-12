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
    func makeRequest<T,U>(for resource: Resource<T>, data: U? = nil, completion: FetchResult<T>?) where U: Codable {
        
        switch resource.requestMethod {
            
        case .GET:
            guard let completion = completion else { return }
            self.getData(from: resource, completion: completion)
        case .POST:
            guard let data = data else { return }
            self.postData(to: resource, data: data)
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
                
                do {
                    let items = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(items))
                    
                } catch let jsonError {
                    completion(.failure(jsonError))
                    
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
    }
    
    //WHEN POST REQUEST
    private func postData <T,U> (to resource: Resource<T>, data: U) where U:Codable {
        
        guard let url = resource.urlComponents.url else { return }
        
        var request = URLRequest (url: url)
        request.httpMethod = resource.requestMethod.rawValue
        
        let encodedResult = self.encode(data: data)
        
        switch encodedResult {
        
        case .success(let httpBody):
            request.httpBody = httpBody
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
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Server error")
                return
            }
            // Success response
            print("HTTP Post successful. Return code: " + String(httpResponse.statusCode))
            if let mimeType = httpResponse.mimeType /*, mimeType == "application/json"*/ {
                print("MimeType: " + mimeType)
            }
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
    
}

