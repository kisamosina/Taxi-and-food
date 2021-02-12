//
//  Resource.swift
//  Taxi and food
//
//  Created by mac on 12/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

enum RequestMethod: String {
    case GET
    case POST
}

struct Resource<T: Decodable> {
    
    var urlComponents: URLComponents
    let requestMethod: RequestMethod
    
    init (_ host: String, path: String, requestType: RequestMethod, queryItems: [URLQueryItem]? = nil) {
        self.requestMethod = requestType
        self.urlComponents = URLComponents()
        self.urlComponents.scheme = "https"
        self.urlComponents.host = host
        self.urlComponents.path = path
        self.urlComponents.queryItems = queryItems
        
    }
}
