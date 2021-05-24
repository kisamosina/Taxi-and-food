//
//  PaymentResponse.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct PaymentResponse: Decodable {
    var data: [PaymentCardResponseData]
}

struct PaymentCardResponseData: Decodable {
    var id: Int
    var number: String
    var expiryDate: String
    var status: String
}

extension PaymentCardResponseData {
    var hidedNumber: String {
        return "****" + String(number.suffix(4))
    }
}
