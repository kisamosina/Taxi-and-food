//
//  AuthModel.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 13.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct RegistrationRequest: Codable {
    var phone: String
}

struct RegistrationResponse: Decodable {
    var data: RegistrationResponseData
}

struct RegistrationResponseData: Decodable {
    var code: String
}

struct ConfirmRequest: Codable {
    var phone: String
    var code: String
}

struct ConfirmResponse: Decodable {
    var id: Int
    var name: String?
    var email: String?
    
}

struct ResponsedSettings: Decodable {
    var id: Int
    var language: String
    var userId: Int
}
