//
//  TarifResponse.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 17.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct TariffRequest: Codable {

}

struct TariffResponse: Decodable {
    var data: [TariffData]
}

struct TariffData: Decodable {
    
    var id: Int
    var name: String
    var cars: String
    var description: String
    var icon: String
    var advantages: [TariffAdvantage]
    
}

struct TariffAdvantage: Decodable {
    var name: String
    var icon: String
}
