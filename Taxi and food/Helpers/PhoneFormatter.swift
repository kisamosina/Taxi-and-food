//
//  PhoneFormatter.swift
//  Ride and food
//
//  Created by Maxim Alekseev on 09.02.2021.
//

import Foundation

struct PhoneFormatter {
    
    var rawText: String = ""
    
    mutating func setRawText(_ text: String) {
        
        if text == "" {
            self.rawText = String(self.rawText.dropLast())
        }
        
        if Int(text) != nil && rawText.count < 11 {
            self.rawText += text
        }
    }
    
    func format(phone: String) -> String {
        let mask = "+X (XXX) XXX-XX-XX"
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
}
