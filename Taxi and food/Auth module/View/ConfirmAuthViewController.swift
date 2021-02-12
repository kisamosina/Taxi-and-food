//
//  ConfirmAuthViewController.swift
//  Taxi and food
//
//  Created by mac on 12/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class ConfirmAuthViewController: UIViewController {
    
    //MARK: - Properties
    
    private var phoneNumber: String?
    private var rawPhoneNumber: String?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tfOne: UITextField!
    @IBOutlet weak var tfTwo: UITextField!
    @IBOutlet weak var tfThree: UITextField!
    @IBOutlet weak var tfFour: UITextField!
    @IBOutlet weak var descriptonLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTextfieldsTargets()
        addKeyboardWillShowObserver()
        setupDescriptonLabelText()
        print(rawPhoneNumber!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tfOne.becomeFirstResponder()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpUIAppears()
        
    }
    
    //MARK: - IBActions
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
    }
    
    
    //MARK: - Methods
    
    func setup(phoneNumber: String, rawPhoneNumber: String) {
        self.phoneNumber = phoneNumber
        self.rawPhoneNumber = rawPhoneNumber
    }
    
    private func setupDescriptonLabelText() {
        self.descriptonLabel.text =
            "На номер \(phoneNumber ?? "") отправлено смс с кодом. Повторная отправка через 29 секунд"
    }
    
    private func addKeyboardWillShowObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func addTextfieldsTargets() {
        tfOne.addTarget(self, action: #selector(self.textDidChange(textField:)), for: .editingChanged)
        tfTwo.addTarget(self, action: #selector(self.textDidChange(textField:)), for: .editingChanged)
        tfThree.addTarget(self, action: #selector(self.textDidChange(textField:)), for: .editingChanged)
        tfFour.addTarget(self, action: #selector(self.textDidChange(textField:)), for: .editingChanged)
    }
    
    private func setUpUIAppears() {
        nextButton.layer.cornerRadius = 15
        tfOne.layer.cornerRadius = 4
        tfTwo.layer.cornerRadius = 4
        tfThree.layer.cornerRadius = 4
        tfFour.layer.cornerRadius = 4
    }
    
    @objc private func textDidChange(textField: UITextField) {
        
        let text = textField.text
        
        if text?.utf16.count == 1 {
            switch textField {
            
            case tfOne:
                tfTwo.becomeFirstResponder()
                
            case tfTwo:
                tfThree.becomeFirstResponder()
                
            case tfThree:
                tfFour.becomeFirstResponder()
                
            case tfFour:
                tfFour.resignFirstResponder()
                
            default:
                break
                
            }
            
        } else if textField.text!.isEmpty {
            switch textField {
            case tfFour:
                tfThree.becomeFirstResponder()
                
            case tfThree:
                tfTwo.becomeFirstResponder()
                
            case tfTwo:
                tfOne.becomeFirstResponder()
                
            default:
                break
            }
        }
    }
    
    
    @objc private func keyboardWillAppear(notification: NSNotification) {
        keyboardWillShow(constraint: nextButtonBottomConstraint, notification: notification)
    }

    @objc private func keyboardWillDisappear(notification: NSNotification) {
        keyboardWillHide(constraint: nextButtonBottomConstraint, notification: notification)
    }
    
}
