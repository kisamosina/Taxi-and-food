//
//  AuthModel.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 13.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct RegistrationResponse: Decodable {
    var data: RegistrationResponseData
}

struct RegistrationResponseData: Decodable {
    var code: Int
}

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
