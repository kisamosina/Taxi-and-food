//
//  NewCardEnterModel.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 09.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct AddNewCardResponse: Decodable {
    var data: AddNewCardResponseData
}

struct AddNewCardResponseData: Decodable {
    var number: String
    var expiryDate: String
    var status: String
}
