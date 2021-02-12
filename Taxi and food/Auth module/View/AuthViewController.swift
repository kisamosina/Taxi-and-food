//
//  AuthViewController.swift
//  Taxi and food
//
//  Created by mac on 12/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    //MARK: - Properties
    
    private var isUserAgreementReceived = false
    private var phoneFormatter = PhoneFormatter(maxNumberCount: 11)
//    internal var interactor: AuthInteractorProtocol!
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var userAgreementButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardWillShowObserver()
        enableNextButton()
        phoneNumberTextField.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpUIAppears()
    }
    
    //MARK: - IBAction
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func userAgreementButtonTapped(_ sender: UIButton) {
        isUserAgreementReceived = !isUserAgreementReceived
        if isUserAgreementReceived {
            let image = UIImage(named: "checkmarkactive")
            userAgreementButton.setBackgroundImage(image, for: .normal)
        } else {
            userAgreementButton.setBackgroundImage(nil, for: .normal)
        }
        
        enableNextButton()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let confirmAuthVC = storyboard.instantiateViewController(identifier: String(describing: ConfirmAuthViewController.self)) as! ConfirmAuthViewController
        confirmAuthVC.setup(phoneNumber: phoneNumberTextField.text ?? "", rawPhoneNumber: self.phoneFormatter.rawText )
        self.navigationController?.pushViewController(confirmAuthVC, animated: true)
    }
    
    //MARK: - Methods
    
    private func setUpUIAppears() {
        nextButton.layer.cornerRadius = 15
        userAgreementButton.layer.cornerRadius = 4
        self.phoneNumberTextField.addBottomBorder()
    }
    
    private func addKeyboardWillShowObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    //Activating next button
    private func enableNextButton() {
        
        if phoneFormatter.rawText.count == 11 && isUserAgreementReceived {
            nextButton.isEnabled = true
            nextButton.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.231372549, blue: 1, alpha: 1)
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.8156862745, alpha: 1)
        }
    }
    
    @objc private func keyBoardWillAppear(notification: NSNotification) {
        keyboardWillShow(constraint: bottomViewConstraint, notification: notification)
    }
    
}

//MARK: - UITextFieldDelegate

extension AuthViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullString = (textField.text ?? "") + string
        textField.text = phoneFormatter.format(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
        phoneFormatter.setRawText(string)
        enableNextButton()
        return false
    }
}




