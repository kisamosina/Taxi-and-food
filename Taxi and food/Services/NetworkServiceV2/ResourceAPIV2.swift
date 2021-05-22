//
//  ResourceAPIV2.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 22.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct ResourceAPIV2 {
    
    var header: [String: String]
    var urlComponents: URLComponents
    
    init (path: String, queryItems: [URLQueryItem]? = nil, header: [String: String] = [:]) {
        self.urlComponents = URLComponents()
        self.urlComponents.scheme = NetworkConfig.scheme.rawValue
        self.urlComponents.host = NetworkConfig.host.rawValue
        self.urlComponents.path = NetworkConfig.basePath.rawValue + path
        self.urlComponents.queryItems = queryItems
        self.header = header
    }
}
