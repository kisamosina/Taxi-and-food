//
//  DateFormatter+Extension.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 24.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    func getDateWithPoints(date: Date) -> String{
        self.dateFormat = "dd.MM.yy"
        return self.string(from: date)
    }
    
    func getDateByDay(date: Date) -> String {
        self.dateFormat = "d MMMM, HH:mm"
        return self.string(from: date)
    }
}
