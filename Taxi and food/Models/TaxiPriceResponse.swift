//
//  TaxiPriceResponseData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 28.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct TaxiPriceResponseModel: Decodable {
    
    let tariff: TariffData
    let price: Int
    let discount: Int
    let credit: Int?
}

extension TaxiPriceResponseModel {
    
    struct TariffData: Decodable {
        let id: Int
        let name: String
    }
}
