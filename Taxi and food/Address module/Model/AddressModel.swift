//
//  AddressModel.swift
//  Taxi and food
//
//  Created by mac on 10/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct AddressResponse: Decodable {
    var data: [AddressResponseData]
    
}

struct AddressResponseData: Decodable {
    var id: Int
    var name: String?
    var address: String?
    var commentDriver: String?
    var commentCourier: String?
    var flat: Int?
    var intercom: Int?
    var entrance: Int?
    var floor: Int?
    var destination: Bool?
}

