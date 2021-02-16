//
//  UILabel+Extension.swift
//  Ride and food
//
//  Created by Maxim Alekseev on 11.02.2021.
//

import UIKit

extension UILabel {
    
    func setAttributedText(_ attext: String) {
        guard let text = text else { return }
        
        let underlineAttribString = NSMutableAttributedString(string: text)
        
        let range = (text as NSString).range(of: attext)
        
        underlineAttribString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        underlineAttribString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range)
        attributedText = underlineAttribString
        isUserInteractionEnabled = true
        
    }
    
}
