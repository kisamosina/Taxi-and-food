//
//  ConfirmResponse.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct ConfirmResponse: Decodable {
    var data: ConfirmResponseData
}

struct ConfirmResponseData: Decodable {
    var id: Int
    var name: String?
    var email: String?
    var setting: ResponsedSettings?
}

struct ResponsedSettings: Decodable {
    var language: String
}
