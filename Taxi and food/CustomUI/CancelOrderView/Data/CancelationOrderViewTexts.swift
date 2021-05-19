//
//  CancelOrderViewTexts.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 19.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct CancelationOrderViewTexts: TranslatableTexts {

    static var cancelationReasonHeader: String {
        switch lang {
        case .rus:
            return "Причина отмены"
        case .eng:
            return "Cancelation reason"
        }
    }
    
}

extension CancelationOrderViewTexts {
    
    private enum CancelationReasonsRus: String, CaseIterable {
        case plansChanged = "Поменялись планы"
        case mistake = "Заказ совершен по ошибке"
        case longWaiting = "Долгое ожидание заказа"
        case withoutReason = "Без указания причины"
    }
    
    private enum CancelationReasonsEng: String, CaseIterable {
        case plansChanged = "Plans has changed"
        case mistake = "Order has done by mistake"
        case longWaiting = "Long waiting"
        case withoutReason = "Without reason"
    }
    
    static var cancelationReasons: [String] {
            
        switch lang {
        case .rus:
            return CancelationReasonsRus.allCases.map { $0.rawValue }
        case .eng:
            return CancelationReasonsEng.allCases.map { $0.rawValue }
        }
    }
}
