//
//  String+Extension.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 15.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation

extension String {
    
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
    
    func getPromoDescription(for id: Int) -> String {
        
        return "\(self)/\(id)"
    }
    
    func addNanoSec() -> String {
        return "\(self) +0000"
    }
}
