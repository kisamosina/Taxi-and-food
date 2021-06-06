//
//  PaymentResponse.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct PaymentResponse: Decodable {
    let data: [PaymentCardResponseData]
}

struct PaymentCardResponseData: Decodable {
    let id: Int
    let number: String
    let expiryDate: String
    let status: String
}

extension PaymentCardResponseData {
    var hidedNumber: String {
        return "****" + String(number.suffix(4))
    }
}
