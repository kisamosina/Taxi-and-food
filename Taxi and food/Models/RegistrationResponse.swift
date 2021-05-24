//
//  RegistrationResponse.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct RegistrationResponse: Decodable {
    var data: RegistrationResponseData
}

struct RegistrationResponseData: Decodable {
    var code: Int
}
