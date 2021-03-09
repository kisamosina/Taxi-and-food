//
//  EnterCardView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 08.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class CardEnterView: UIView {
    
    weak var delegate: CardEnterViewDelegate?

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var cvcTextField: UITextField!
    @IBOutlet weak var linkCardButton: MainBottomButton!
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Setup layers
        self.contentView.layer.cornerRadius = CardEnterViewUIData.cornerRadius.rawValue
        self.contentView.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.contentView.layer.shadowOpacity = Float(CardEnterViewUIData.shadowOpacity.rawValue)
        self.contentView.layer.shadowRadius = CardEnterViewUIData.cornerRadius.rawValue
        self.contentView.layer.shadowOffset = CGSize(width: CardEnterViewUIData.shadowOffsetWidth.rawValue,
                                                  height: CardEnterViewUIData.shadowOffsetWidth.rawValue)
        self.contentView.layer.masksToBounds = false
        self.topView.layer.cornerRadius = CardEnterViewUIData.upViewHeight.rawValue / 2
        self.topView.clipsToBounds = true
        self.cardNumberTextField.addBottomBorder(color: Colors.buttonGrey.getColor())
        self.dateTextField.addBottomBorder(color: Colors.buttonGrey.getColor())
        self.cvcTextField.addBottomBorder(color: Colors.buttonGrey.getColor())
        
        //Set UI data
        self.topView.backgroundColor = Colors.InactiveViewColor.getColor()
        self.linkCardButton.setupAs(.linkACard)
        self.linkCardButton.setInActive()
        self.cardNumberTextField.placeholder = CardEnterViewTexts.cardNumberPlaceholderText
        self.dateTextField.placeholder = CardEnterViewTexts.datePlaceholderText
        self.cvcTextField.placeholder = CardEnterViewTexts.cvcPlaceHolderText
        self.cardNumberTextField.becomeFirstResponder()
        self.cardNumberTextField.addTarget(self, action: #selector (didChangeText(textField:)), for: .editingChanged)
        self.linkCardButton.addTarget(self, action: #selector(linkCardButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func linkCardButtonTapped() {
        guard let cardNumber = self.cardNumberTextField.text?.filter({ $0 != " "}),
              let expirationDate = self.dateTextField.text,
              let cvv = self.cvcTextField.text,
              cardNumber.count == 16,
              expirationDate.count == 5,
              cvv.count == 3
        else { return }
        self.delegate?.catchCardData(cardNumber:cardNumber, expirationDate: expirationDate, cvv: cvv)
    }
    
    @objc func didChangeText(textField:UITextField) {
        guard let text = textField.text else { return }
        self.cardNumberTextField.text = text.modifyCreditCardString()
        
        if text.count >= 4 {
        let imageView = UIImageView()
        imageView.image = UIImage(named: CustomImagesNames.visaIcon.rawValue)
        self.cardNumberTextField.rightView = imageView
        self.cardNumberTextField.rightViewMode = .always
        } else {
            self.cardNumberTextField.rightViewMode = .never
        }
    }
    
    private func setLinkCardButtonActive() {
        guard self.cardNumberTextField.text?.count == 19 && self.dateTextField.text?.count == 5 && (self.cvcTextField.text?.count ?? 0) >= 2 else {
            self.linkCardButton.setInActive()
            return
        }
        
        self.linkCardButton.setActive()
    }
}

extension CardEnterView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newLength = (textField.text ?? "").count + string.count - range.length
        
        switch textField {
        
        case cardNumberTextField:
            self.setLinkCardButtonActive()
            return newLength <= 19
            
        case dateTextField:
            self.setLinkCardButtonActive()
            return ExpirationDateFormatter.checkText(in: textField, range: range, string: string)
            
        case cvcTextField:
            self.setLinkCardButtonActive()
            return newLength <= 3
            
        default:
            return true
        }
    }
    
}
