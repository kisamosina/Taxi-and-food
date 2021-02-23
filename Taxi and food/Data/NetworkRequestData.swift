//
//  NetworkRequestData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 15.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

enum RegistrationRequestPaths: String {
    case registration = "auth/registration"
    case confirm = "auth/confirm"
}

enum RegistrationRequestKeys: String {
    case phone
    case code
}

enum PromocodesRequestPaths: String {
    case activate = "user/$/promo-codes/activate"
}

enum PromocodesRequestKeys: String {
    case code
}
