//
//  ViewController.swift
//  Ride and food
//
//  Created by Maxim Alekseev on 09.02.2021.
//

import UIKit

protocol AuthViewProtocol: class {
    var interactor: AuthInteractorProtocol! { get set }
}

class AuthViewController: UIViewController {
    
    //MARK: - Properties
    internal var interactor: AuthInteractorProtocol!
    
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
        self.interactor = AuthInteractor(view: self)
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
        interactor.isUserAgreementReceived = !interactor.isUserAgreementReceived
        if interactor.isUserAgreementReceived {
            let image = UIImage(named: CustomImagesNames.checkMark.rawValue)
            userAgreementButton.setImage(image, for: .normal)
        } else {
            userAgreementButton.setImage(nil, for: .normal)
        }
        
        enableNextButton()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: StoryBoards.AuthAndMap.rawValue, bundle: nil)
        let confirmAuthVC = storyboard.instantiateViewController(identifier: ViewControllers.ConfirmAuthViewController.rawValue) as! ConfirmAuthViewController
        confirmAuthVC.setup(phoneNumber: phoneNumberTextField.text ?? "", rawPhoneNumber: interactor.phoneFormatter.rawText )
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
        
        if interactor.phoneFormatter.rawText.count == 11 && interactor.isUserAgreementReceived {
            nextButton.isEnabled = true
            nextButton.backgroundColor = Colors.buttonBlue.getColor()
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = Colors.buttonGrey.getColor()
        }
    }
    
    private func setLabelsAndButtonsText() {
        
        self.topLabel.text = interactor.topLabelText
        self.bottomLabel.text = interactor.bottomLabelText
        self.bottomLabel.setAttributedText(interactor.userAgreementText)
        self.nextButton.setTitle(interactor.nextButtonTitle, for: .normal)
        
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
        
        let termsRange = (text as NSString).range(of: interactor.userAgreementText)
        
        if gesture.didTapAttributedTextInLabel(label: bottomLabel, inRange: termsRange) {
            guard let uaVC = storyboard?.instantiateViewController(identifier: ViewControllers.UserAgreementViewController.rawValue)
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
        textField.text = interactor.phoneFormatter.format(phone: newString)
        interactor.phoneFormatter.setRawText(string)
        enableNextButton()
        return false
    }
}

//MARK: - AuthViewProtocol

extension AuthViewController: AuthViewProtocol {}



