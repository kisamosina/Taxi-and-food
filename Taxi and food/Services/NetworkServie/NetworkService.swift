//
//  NetworkService.swift
//  Taxi and food
//
//  Created by mac on 12/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    typealias FetchResult<T:Decodable> = (Result<T, Error>) -> Void
    typealias RequestWithoutResponse = () -> Void
    typealias WebImage = (Data?) -> Void
    
    //Make networking requests
    func makeRequest<T>(for resource: Resource<T>, completion: @escaping FetchResult<T>, completionWithNoResponse: RequestWithoutResponse? = nil) {
        
        switch resource.requestMethod {
        
        case .GET:
            self.getData(from: resource, completion: completion)
        case .POST:
            self.postData(to: resource, completion: completion, completionWithNoResponse: completionWithNoResponse)
        case .PUT:
            self.putMethod(to: resource, completion: completion)
        case .DELETE:
            self.deleteMethod(from: resource, completion: completion)
        }
    }
    
    //Loading images
    func loadImageData(for urlString: String, completion: @escaping WebImage) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        DispatchQueue.global(qos: .utility).async {
            
            guard let imageData: Data = try? Data(contentsOf: url) else {
                completion(nil)
                return
            }
            completion(imageData)
        }
    }
    
    //GET REQUEST
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
    
    //WHEN DELETE REQUEST
    
   
    
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
    
    
    //WHEN DELETE METHOD
    
    func deleteMethod <T: Decodable>(from resource: Resource<T>, completion: @escaping FetchResult<T>) {
        
        guard let url = resource.urlComponents.url, let requestData = resource.requestData  else { return }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = resource.requestMethod.rawValue
        let serializedResult = self.serilizeData(requestData)
        
        switch serializedResult {
        
        case .success(let jsonObject):
            print(jsonObject)
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
                    print("error calling PUT on (url)")
                    print(error!)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else { return }
                guard (200...299).contains(httpResponse.statusCode) else {
                    print("Server error code: \(httpResponse.statusCode)")
                    let error = ServerErrors(statusCode: httpResponse.statusCode)
                    completion(.failure(error))
                    return
                }
                // Success response
                print("HTTP Put successful. Return code: " + String(httpResponse.statusCode))

                guard let data = data else { return }
                let result = self.decode(for: resource, data: data)
                completion(result)
            }
            
            task.resume()
  
    }
    
    
    
    //WHEN PUT METHOD

    func putMethod <T> (to resource: Resource<T>, completion: @escaping FetchResult<T>) {
        guard let url = resource.urlComponents.url, let requestData = resource.requestData  else { return }

    // Create the request
    var request = URLRequest(url: url)
    request.httpMethod = resource.requestMethod.rawValue
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let serializedResult = self.serilizeData(requestData)
        
    switch serializedResult {
            
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
                    print("error calling PUT on (url)")
                    print(error!)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else { return }
                guard (200...299).contains(httpResponse.statusCode) else {
                    print("Server error code: \(httpResponse.statusCode)")
                    let error = ServerErrors(statusCode: httpResponse.statusCode)
                    completion(.failure(error))
                    return
                }
                // Success response
                print("HTTP Put successful. Return code: " + String(httpResponse.statusCode))

                guard let data = data else { return }
                let result = self.decode(for: resource, data: data)
                completion(result)
            }
            
            task.resume()
        
    }
            
    
    
    
    //POST REQUEST
    private func postData <T> (to resource: Resource<T>, completion: @escaping FetchResult<T>, completionWithNoResponse: RequestWithoutResponse? = nil) {
        
        guard let url = resource.urlComponents.url else { return }
        
        var request = URLRequest (url: url)
        request.httpMethod = resource.requestMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let requestData = resource.requestData {
            let serializedResult = self.serilizeData(requestData)
            switch serializedResult {
            
            case .success(let httpBody):
                request.httpBody = httpBody
            case .failure(let error):
                print("CATCHED ERROR WHILE ENCODING DATA: \(error.localizedDescription)" )
                return
            }
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
            
            guard (200...299).contains(httpResponse.statusCode)
            else {
                print("Server error code: \(httpResponse.statusCode)")
                let error = ServerErrors(statusCode: httpResponse.statusCode)
                completion(.failure(error))
                return
            }
            
            // Success response
            print("HTTP Post successful. Return code: " + String(httpResponse.statusCode))
            
            // When response with no data
            if let completionWithNoResponse = completionWithNoResponse {
                completionWithNoResponse()
                return
            }
            
            //When response has data
            guard let data = data else { return }
            let result = self.decode(for: resource, data: data)
            completion(result)
        }
        
        task.resume()
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
    
    //SERILIZE DATA
    private func serilizeData(_ data: [String: Any]) -> Result<Data, Error> {
        
        do {
            
            let result = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            return .success(result)
            
        } catch {
            return .failure(error)
        }
        
        
    }
    
}

