//
//  PromocodeResponse.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 23.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct PromocodeResponse: Decodable {
    var data: PromocodeDataResponse
}

struct PromocodeDataResponse: Decodable {
    var description: String
}
