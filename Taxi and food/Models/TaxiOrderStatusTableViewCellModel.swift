//
//  TaxiOrderStatusTableViewCellModel.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct TaxiOrderStatusTableViewCellModel {
    let parameter: String
    let parameterImageName: String
}

extension TaxiOrderStatusTableViewCellModel {
    
    static func generateTaxiOrderStatusTableViewCellModel() -> [TaxiOrderStatusTableViewCellModel] {
        let changeAddressTrip = TaxiOrderStatusTableViewCellModel(parameter: TaxiOrderStatusTableViewCellModelTexts.changeAddressTrip, parameterImageName: CustomImagesNames.userPinOrange.rawValue)
        let specifyArrivalPlace = TaxiOrderStatusTableViewCellModel(parameter: TaxiOrderStatusTableViewCellModelTexts.specifyArrivalPlace, parameterImageName: CustomImagesNames.userPin.rawValue)
        let cancelOrder = TaxiOrderStatusTableViewCellModel(parameter: TaxiOrderStatusTableViewCellModelTexts.cancelOrder, parameterImageName: CustomImagesNames.iconOrderCancelation.rawValue)
        
        return [changeAddressTrip, specifyArrivalPlace, cancelOrder]
    }
}
