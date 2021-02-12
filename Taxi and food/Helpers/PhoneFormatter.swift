//
//  PhoneFormatter.swift
//  Taxi and food
//
//  Created by mac on 12/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

struct PhoneFormatter {
    
    private let maxNumberCount: Int
    private let regex = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
    var rawText: String = ""
    
    init(maxNumberCount: Int ) {
        self.maxNumberCount = maxNumberCount
    }
    
    mutating func setRawText(_ text: String) {
        
        if text == "" {
            self.rawText = String(self.rawText.dropLast())
        }
        
        if Int(text) != nil && rawText.count < 11 {
            self.rawText += text
        }
    }
    
    func format(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
            guard !(shouldRemoveLastDigit && phoneNumber.count <= 2) else { return "+" }
            
            let range = NSString(string: phoneNumber).range(of: phoneNumber)
            var number = regex.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
            
            if number.count > maxNumberCount {
                let maxIndex = number.index(number.startIndex, offsetBy: maxNumberCount)
                number = String(number[number.startIndex..<maxIndex])
            }
            
            if shouldRemoveLastDigit {
                let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
                number = String(number[number.startIndex..<maxIndex])
            }
            
            let maxIndex = number.index(number.startIndex, offsetBy: number.count)
            let regRange = number.startIndex..<maxIndex
            
            if number.count < 7 {
                let pattern = "(\\d)(\\d{3})(\\d+)"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
            } else {
                let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
            }
            
            return "+" + number
        }
    
}
