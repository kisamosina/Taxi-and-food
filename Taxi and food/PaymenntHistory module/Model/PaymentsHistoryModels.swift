//
//  PaymentsModels.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 27.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct PaymentsHistoryResponse: Decodable {
    var data: [PaymentsHistoryResponseData]
}

struct PaymentsHistoryResponseData: Decodable {
    
    var id: Int
    var paid: Int
    var method: String
    var status: Int
    var order: Int
    var paymentCard: PaymentCardResponse
}


struct PaymentCardResponse: Decodable {
    var number: String
    var system: String
}
