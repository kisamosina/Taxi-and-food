//
//  AboutPointsViewUIData.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 18.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

enum AboutPointsViewSizes: CGFloat {
    case topPadding = 80
}

enum AboutPointsViewStringData: String {
    case nibName = "AboutPointsView"
}

struct AboutPointsViewTexts {
    
    private enum RusTexts: String {
        case title = "Пользуйтесь сервисом – копите баллы!"
        case description = "Программа лояльности для пользователей сервисами приложения «Ride & Drive». Программа предназначена для накопления баллов пользователем при оплате любым способом. 1 балл приравнивается к 1 рублю. При использовании сервиса «Такси» баллы начисляются согласно ставке 10% от суммы заказа свыше 800 рублей единовременно. При использовании сервиса «Еда» баллы начисляются согласно ставке 5% от суммы заказа свыше 1000 рублей единовременно. Использование баллов дает право пользователю на комбинированную оплату заказа. При оплате баллами заказа сервиса «Такси» минимальная сумма заказа – 200 рублей, максимальная оплата баллами – 50 баллов.  При оплате баллами заказа сервиса «Еда» минимальная сумма заказа – 300 рублей, максимальная оплата баллами – 50 баллов. "
    }
    
    enum EngTexts: String {
        case title = "Use the service - collect points!"
        case description = "Loyalty program for users of the services of the Ride & Drive application. The program is intended for the accumulation of points by the user when paying in any way. 1 point is equal to 1 ruble. When using the Taxi service, points are awarded at a rate of 10% of the order amount over 800 rubles at a time. When using the Food service, points are awarded at a rate of 5% of the order amount over 1000 rubles at a time. The use of points entitles the user to a combined order payment. When paying with points for ordering the Taxi service, the minimum order amount is 200 rubles, the maximum payment with points is 50 points. When paying with points for ordering the Food service, the minimum order amount is 300 rubles, the maximum payment with points is 50 points."
    }
    
    static var titleText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTexts.title.rawValue
        case .eng:
            return EngTexts.title.rawValue
        }
    }
    
    static var descriptionText: String {
        
        switch UserDefaults.standard.getAppLanguage() {
        
        case .rus:
            return RusTexts.description.rawValue
        case .eng:
            return EngTexts.description.rawValue
        }
    }

}
