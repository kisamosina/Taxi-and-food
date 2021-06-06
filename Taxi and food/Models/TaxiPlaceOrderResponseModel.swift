//
//  TaxiPlaceOrderResponseModel.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 25.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct TaxiPlaceOrderResponseModel: Decodable {
    let data: TaxiPlaceOrderResponseDataModel
    let taxi: TaxiResponseData
}

struct TaxiPlaceOrderResponseDataModel: Decodable {
    let id: Int
    let from: String
    let to: String
    let credit: Int
//    let distance: Int
    let price: Int
    let discount: Int
//    let forPayment: Int
//    let type: String
//    let status: String
//    let comment: String
    let tariff: TariffData
}


extension TaxiPlaceOrderResponseDataModel {
    struct TariffData: Decodable {
        let id: Int
        let name: String
//        let cars: String
//        let description: String
//        let icon: String
    }
}


struct TaxiResponseData: Decodable {
    let id: Int
    let car: String
    let color: String
    let number: String
    let regionNumber: String
    let imageMap: String
    let imageOrder: String
    let imageHistory: String
}

extension TaxiPlaceOrderResponseModel {
    
    static func makeTaxiPlaceOrderResponseModel(from: String, to: String, credit: Int, price: Int) -> TaxiPlaceOrderResponseModel {
        let taxi = TaxiResponseData(id: 1, car: "Kia Rio", color: "Белый", number: "К660АК", regionNumber: "116", imageMap: "", imageOrder: CustomImagesNames.carSample.rawValue, imageHistory: "")
        let data = TaxiPlaceOrderResponseDataModel(id: 1, from: from, to: to, credit: credit, price: price, discount: 0, tariff: TaxiPlaceOrderResponseDataModel.TariffData(id: 1, name: "Standart"))
        return TaxiPlaceOrderResponseModel(data: data, taxi: taxi)
    }
}
