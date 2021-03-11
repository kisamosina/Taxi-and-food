//
//  String+Extension.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 15.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

extension String {
    
    var iso8601withFractionalSeconds: Date? { return Formatter.iso8601withFractionalSeconds.date(from: self) }
       
    func setDescription(for seconds: Int, and phoneNumber: String) -> String {
        
        let temp = self.split(separator: "$")
        
        if seconds == 0 {
            return "\(temp[0]) \(phoneNumber) \(temp[1]) \(ConfirmAuthViewControllerTexts.resendText)"
            
        } else {
            switch UserDefaults.standard.getAppLanguage() {
            case .rus:
                return "\(temp[0]) \(phoneNumber) \(temp[1]) \(temp[2]) \(seconds) \(ConfirmAuthViewControllerTexts.ruSeconds(seconds))."
            case .eng:
                return "\(temp[0]) \(phoneNumber) \(temp[1]) \(temp[2]) \(seconds) \(temp[3])."
            }
        }
    }
    
    func getServerPath(for id: Int) -> String {
        let temp = self.split(separator: "$")
        return "\(temp[0])\(id)\(temp[1])"
    }
    
    func getPromo(by type: String) -> String {
        return "\(self)/\(type)"
    }
    
    func modifyCreditCardString() -> String {
         let trimmedString = self.components(separatedBy: .whitespaces).joined()

         let arrOfCharacters = Array(trimmedString)
         var modifiedCreditCardString = ""

         if(arrOfCharacters.count > 0) {
             for i in 0...arrOfCharacters.count-1 {
                 modifiedCreditCardString.append(arrOfCharacters[i])
                 if((i+1) % 4 == 0 && i+1 != arrOfCharacters.count){
                     modifiedCreditCardString.append(" ")
                 }
             }
         }
         return modifiedCreditCardString
     }
    
    func insert(text: String) -> String {
        let temp = self.split(separator: "$")
        return "\(temp[0]) \(text) \(temp[1])"
    }
}
