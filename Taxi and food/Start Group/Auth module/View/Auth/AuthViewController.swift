//
//  ViewController.swift
//  Ride and food
//
//  Created by Maxim Alekseev on 09.02.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    //MARK: - Properties
    
    private var isUserAgreementReceived = false
    private var phoneFormatter = PhoneFormatter()
    private var userAgreementText: String {
        switch AppSettings.shared.language {
        
        case .rus:
            return "пользовательским соглашением"
        case .en:
            return "user agreement"
        }
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var userAgreementButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addKeyboardWillShowObserver()
        enableNextButton()
        setLabelsAndButtonsText()
        addBottomLabelGestureRecognizer()
        phoneNumberTextField.delegate = self
        notificationRequest()
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
    
    private func setLabelsAndButtonsText() {
        
        switch AppSettings.shared.language {
        
        case .rus:
            topLabel.text = "Укажите номер телефона"
            bottomLabel.text = "Даю согласие на обработку персональных данных, с пользовательским соглашением ознакомлен"
            bottomLabel.setAttributedText(userAgreementText)
            nextButton.setTitle("Далее", for: .normal)
        case .en:
            topLabel.text = "Set telephone number"
            bottomLabel.text = "I agree to the personal data processing, I have read the user agreement"
            bottomLabel.setAttributedText(userAgreementText)
            nextButton.setTitle("Next", for: .normal)
        }
        
    }
    
    private func addBottomLabelGestureRecognizer() {
        bottomLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBottomLabel(gesture:))))
    }
    
    private func notificationRequest() {
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
    @objc private func keyBoardWillAppear(notification: NSNotification) {
        keyboardWillShow(constraint: bottomViewConstraint, notification: notification)
    }
    
    @objc func tapBottomLabel(gesture: UITapGestureRecognizer) {
        guard let text = bottomLabel.text else { return }
        
        let termsRange = (text as NSString).range(of: userAgreementText)
        
        if gesture.didTapAttributedTextInLabel(label: bottomLabel, inRange: termsRange) {
            guard let uaVC = storyboard?.instantiateViewController(identifier: String(describing: UserAgreementViewController.self))
            else { return }
            self.present(uaVC, animated: true, completion: nil)
        }
    }
}

//MARK: - UITextFieldDelegate

extension AuthViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = phoneFormatter.format(phone: newString)
        phoneFormatter.setRawText(string)
        enableNextButton()
        return false
    }
}



