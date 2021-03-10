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
    case PUT
}

struct Resource<T: Decodable> {
    
    var urlComponents: URLComponents
    let requestMethod: RequestMethod
    var requestData: [String: Any]?
    
    init (path: String, requestType: RequestMethod, queryItems: [URLQueryItem]? = nil, requestData: [String: Any]? = nil) {
        self.requestMethod = requestType
        self.urlComponents = URLComponents()
        self.urlComponents.scheme = "https"
        self.urlComponents.host = "skillbox.cc"
        self.urlComponents.path = "/api/" + path
        self.urlComponents.queryItems = queryItems
        self.requestData = requestData
    }
}
