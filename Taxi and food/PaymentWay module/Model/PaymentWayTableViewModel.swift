//
//  PaymentWayTableViewModel.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 06.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct PaymentWayTableViewModel {
    var sections: [PaymentWayTableViewSectionModel]
}

struct PaymentWayTableViewSectionModel {
    var cells: [PaymentWayTableViewCellModel]
}

struct PaymentWayTableViewCellModel {

    enum CheckMarkState {
        case active
        case inactive
        case enter
    }
    
    var checkMark: CheckMarkState
    var title: String
    var iconName: String?
    
    var checkMarkImage: String {
        switch checkMark {
            
        case .active:
            return CustomImagesNames.paymentWayActiveCellCheckmark.rawValue
        case .inactive:
            return CustomImagesNames.paymentWayInActiveCellCheckmark.rawValue
        case .enter:
            return CustomImagesNames.paymentWayEnterCellCheckmark.rawValue
        }
    }
}
