//
//  ExpirationDateFormatter.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 08.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class ExpirationDateFormatter {
    
    static func checkText(in textField: UITextField, range: NSRange, string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        let updatedText = oldText.replacingCharacters(in: r, with: string)
        
        if string == "" {
            if updatedText.count == 2 {
                textField.text = "\(updatedText.prefix(1))"
                return false
            }
        } else if updatedText.count == 1 {
            if updatedText > "1" {
                return false
            }
        } else if updatedText.count == 2 {
            if updatedText <= "12" { //Prevent user to not enter month more than 12
                textField.text = "\(updatedText)/" //This will add "/" when user enters 2nd digit of month
            }
            return false
        } else if updatedText.count == 5 {
            return self.expDateValidation(dateStr: updatedText)
        } else if updatedText.count > 5 {
            return false
        }
        
        return true
    }
    
    private static func expDateValidation(dateStr:String) -> Bool {
        
        let currentYear = Calendar.current.component(.year, from: Date()) % 100   // This will give you current year (i.e. if 2019 then it will be 19)
        let currentMonth = Calendar.current.component(.month, from: Date()) // This will give you current month (i.e if June then it will be 6)
        
        let enteredYear = Int(dateStr.suffix(2)) ?? 0 // get last two digit from entered string as year
        let enteredMonth = Int(dateStr.prefix(2)) ?? 0 // get first two digit from entered string as month
//        print(dateStr) // This is MM/YY Entered by user
        
        if enteredYear > currentYear {
            return (1 ... 12).contains(enteredMonth)
        } else if currentYear == enteredYear {
            return enteredMonth >= currentMonth && (1 ... 12).contains(enteredMonth)
        }
        
        return false
    }
}
