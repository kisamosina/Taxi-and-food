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
    
    func setBlackColor(_ fortext: String) {
        guard let text = text else { return }
        let attribstring = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: fortext)
        attribstring.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
        attributedText = attribstring
    }
    
    func setBold(_ forText: String) {
        guard let text = text else { return }
        let attribstring = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: forText)
        attribstring.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: self.font.pointSize), range: range)
        attributedText = attribstring
    }
    
    func setBoldAndBlack(_ forText: String) {
        guard let text = text else { return }
        let attribstring = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: forText)
        attribstring.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: self.font.pointSize), range: range)
        attribstring.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
        attributedText = attribstring
    }
    
    func setBoldAndOrange(_ forText: String) {
        guard let text = text else { return }
        let attribstring = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: forText)
        attribstring.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: self.font.pointSize), range: range)
        attribstring.addAttribute(NSAttributedString.Key.foregroundColor, value: Colors.bouncesPointsTextColor.getColor(), range: range)
        attributedText = attribstring
    }
    
}
