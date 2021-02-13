//
//  ConfirmAuthViewController.swift
//  Ride and food
//
//  Created by Maxim Alekseev on 10.02.2021.
//

import UIKit

protocol ConfirmAuthViewProtocol: class {
    var interactor: ConfirmAuthInteractorProtocol! { get set }
}

class ConfirmAuthViewController: UIViewController {
    
    //MARK: - Properties
    
    internal var interactor: ConfirmAuthInteractorProtocol!
    private var phoneNumber: String?
    private var rawPhoneNumber: String?
    private var remainedSeconds = 30
    private var timer: Timer?
    private var resendText: String {
        switch AppSettings.shared.language {
        
        case .rus:
            return "Повторить отправку."
        case .en:
            return "Resend code."
        }
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var tfOne: UITextField!
    @IBOutlet weak var tfTwo: UITextField!
    @IBOutlet weak var tfThree: UITextField!
    @IBOutlet weak var tfFour: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = ConfirmAuthInteractor(view: self, phoneNumber: self.rawPhoneNumber!)
        self.interactor.sendRegistrationRequest()
        addTextfieldsTargets()
        addKeyboardWillShowObserver()
        setupTopLabelTextAndNextButtonText()
        setupDescLabelText(seconds: 30)
        startTimer()
        addDescriptionLabelGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tfOne.becomeFirstResponder()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpUIAppears()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }
    
    //MARK: - IBActions
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
    }
    
    
    //MARK: - Methods
    
    func setup(phoneNumber: String, rawPhoneNumber: String) {
        self.phoneNumber = phoneNumber
        self.rawPhoneNumber = rawPhoneNumber
    }
    
    private func setupTopLabelTextAndNextButtonText() {
        
        switch AppSettings.shared.language {
        
        case .rus:
            topLabel.text = "Код подтверждения"
            nextButton.setTitle("Далее", for: .normal)
        case .en:
            topLabel.text = "Approval code"
            nextButton.setTitle("Next", for: .normal)
        }
        
    }
    
    private func setupDescLabelText(seconds: Int) {
        
        var ruSeconds: String {
            switch seconds {
            case 1, 21:
                return "секунду"
            case 2, 3, 4, 22, 23, 24:
                return "секунды"
            default:
                return "секунд"
            }
        }
        
        switch AppSettings.shared.language {
        
        case .rus:
            
            if seconds == 0 {
                self.descriptionLabel.text = "На номер \(phoneNumber ?? "") отправлено СМС с кодом. \(resendText)"
                self.descriptionLabel.setAttributedText(resendText)
            } else {
                self.descriptionLabel.text = "На номер \(phoneNumber ?? "") отправлено СМС с кодом. Повторная отправка будет доступна через \(seconds) \(ruSeconds)."
                self.descriptionLabel.setAttributedText("\(seconds) \(ruSeconds).")
            }
        case .en:
            if seconds == 0 {
                self.descriptionLabel.text = "On number \(phoneNumber ?? "") sended SMS with code. \(resendText)"
                self.descriptionLabel.setAttributedText(resendText)
            } else {
                self.descriptionLabel.text =
                    "On number \(phoneNumber ?? "") sended SMS with code. Resend will be available after \(seconds) seconds."
                self.descriptionLabel.setAttributedText("\(seconds) seconds.")
            }
        }
        
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
    
    private func addDescriptionLabelGestureRecognizer() {
        descriptionLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDescriptionLabel(gesture:))))
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
    
    
    private func startTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            
            self.remainedSeconds -= 1
            self.setupDescLabelText(seconds: self.remainedSeconds)
            if self.remainedSeconds == 0 {
                self.stopTimer()
            }
            
        })
        
        timer?.tolerance = 0.1
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func keyboardWillAppear(notification: NSNotification) {
        keyboardWillShow(constraint: nextButtonBottomConstraint, notification: notification)
    }
    
    @objc private func keyboardWillDisappear(notification: NSNotification) {
        keyboardWillHide(constraint: nextButtonBottomConstraint, notification: notification)
    }
    
    @objc func tapDescriptionLabel(gesture: UITapGestureRecognizer) {
        guard let text = descriptionLabel.text else { return }
        
        let range = (text as NSString).range(of: resendText)
        
        if gesture.didTapAttributedTextInLabel(label: descriptionLabel, inRange: range) {
            remainedSeconds = 30
            startTimer()
        }
    }
}

//MARK: - ConfirmAuthViewProtocol
extension ConfirmAuthViewController: ConfirmAuthViewProtocol {}
