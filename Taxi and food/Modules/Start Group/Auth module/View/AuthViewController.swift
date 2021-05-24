//
//  ViewController.swift
//  Ride and food
//
//  Created by Maxim Alekseev on 09.02.2021.
//

import UIKit

protocol AuthViewProtocol: AnyObject {
    var interactor: AuthInteractorProtocol! { get set }
}

class AuthViewController: UIViewController {
    
    //MARK: - Properties
    internal var interactor: AuthInteractorProtocol!
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var userAgreementButton: UIButton!
    @IBOutlet weak var nextButton: MainBottomButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = AuthInteractor(view: self)
        self.addKeyboardWillShowObserver()
        self.setLabelsAndButtonsText()
        self.addBottomLabelGestureRecognizer()
        self.phoneNumberTextField.delegate = self
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
            let image = UIImage(named: CustomImagesNames.CheckMark.rawValue)
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
        userAgreementButton.layer.cornerRadius = 4
        self.phoneNumberTextField.addBottomBorder(color: Colors.buttonGrey.getColor())
    }
    
    private func addKeyboardWillShowObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    //Activating next button
    private func enableNextButton() {
        
        if interactor.phoneFormatter.rawText.count == 11 && interactor.isUserAgreementReceived {
            self.nextButton.setActive()
        } else {
            self.nextButton.setInActive()
        }
    }
    
    private func setLabelsAndButtonsText() {
        
        self.topLabel.text = AuthViewControllerTextData.topLabelText
        self.bottomLabel.text = AuthViewControllerTextData.bottomLabelText
        self.bottomLabel.setAttributedText(AuthViewControllerTextData.userAgreementText)
        self.nextButton.setupAs(.next)
        
    }
    
    private func addBottomLabelGestureRecognizer() {
        bottomLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBottomLabel(gesture:))))
    }
    
    @objc private func keyBoardWillAppear(notification: NSNotification) {
        keyboardWillShow(constraint: bottomViewConstraint, notification: notification)
    }
    
    @objc func tapBottomLabel(gesture: UITapGestureRecognizer) {
        guard let text = bottomLabel.text else { return }
        
        let termsRange = (text as NSString).range(of: AuthViewControllerTextData.userAgreementText)
        
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



