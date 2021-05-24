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
    
    func setGreyColor(_ fortext: String) {
        guard let text = text else { return }
        let attribstring = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: fortext)
        attribstring.addAttribute(NSAttributedString.Key.foregroundColor, value: Colors.fontGrey.getColor(), range: range)
        attributedText = attribstring
    }

    
    func setColorForText(_ coloredText: String, color: UIColor) {
        guard let text = text else { return }
        let attribstring = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: coloredText)
        attribstring.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
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
    
    func setGreyRoundSeparator(_ forText: String) {
        guard let text = text else { return }
        let attribstring = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: forText)
        attribstring.addAttribute(NSAttributedString.Key.foregroundColor, value: Colors.buttonGrey.getColor(), range: range)
        attributedText = attribstring
    }
    
    func setCrossedText(_ forText: String?) {
        guard text != nil, let forText = forText else {
            text = ""
            return
        }
        let attribstring = NSMutableAttributedString(string: forText)
        attribstring.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attribstring.length))
        attributedText = attribstring
    }
}

//MARK: - UILabel styles

extension UILabel {
    
    func setText(text: String, of style: UILabelStyles = .systemDefault) {
        self.text = text
        
        switch style {
        case .boldOrange(let fontSize):
            font = .systemFont(ofSize: fontSize, weight: .bold)
            textColor = Colors.taxiOrange.getColor()
        case .lightGrey(let fontSize):
            font = .systemFont(ofSize: fontSize, weight: .light)
            textColor = Colors.fontGrey.getColor()
        case .systemDefault:
            font = .systemFont(ofSize: 17)
            textColor = .label
        case .normalGrey(let fontSize):
            font = .systemFont(ofSize: fontSize)
            textColor = Colors.fontGrey.getColor()
        case .headerSemiBold(let fontSize):
            font = .systemFont(ofSize: fontSize, weight: .semibold)
        case .normalBlack(let fontSize):
            font = .systemFont(ofSize: fontSize)
        case .normal(let fontSize):
            font = .systemFont(ofSize: fontSize)
        }
    }
}
