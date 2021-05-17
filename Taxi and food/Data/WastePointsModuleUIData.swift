//
//  WastePointsModuleUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 15.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct WastePointsModuleTexts {
    
    static var errorWhenEnteredPointsMoreCreditsDescription: String {
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return "Введеное число баллов больше чем количество баллов на вашем счете"
        case .eng:
            return "Entered credits more than you have on your account"
        }
    }
    
    static var errorWhenEnteredPointsMoreOrderSumDescription: String {
        switch UserDefaults.standard.getAppLanguage() {
            
        case .rus:
            return "Введеное число баллов больше чем сумма заказа"
        case .eng:
            return "Entered credits more than order sum"
        }
    }
}
