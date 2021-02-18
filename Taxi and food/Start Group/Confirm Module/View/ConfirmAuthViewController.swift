//
//  ConfirmAuthViewController.swift
//  Ride and food
//
//  Created by Maxim Alekseev on 10.02.2021.
//

import UIKit

protocol ConfirmAuthViewProtocol: class {
    var interactor: ConfirmAuthInteractorProtocol! { get set }
    func showMapViewController()
}

class ConfirmAuthViewController: UIViewController {
    
    //MARK: - Properties
    
    internal var interactor: ConfirmAuthInteractorProtocol!
    private var phoneNumber: String?
    private var rawPhoneNumber: String?
    private var remainedSeconds = ConfirmAuthIntData.timerSeconds.rawValue
    private var timer: Timer?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var tfOne: DigitTextField!
    @IBOutlet weak var tfTwo: DigitTextField!
    @IBOutlet weak var tfThree: DigitTextField!
    @IBOutlet weak var tfFour: DigitTextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nextButton: NextButton!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = ConfirmAuthInteractor(view: self, phoneNumber: self.rawPhoneNumber!)
        self.interactor.sendRegistrationRequest()
        addTextfieldsTargets()
        addKeyboardWillShowObserver()
        setupTopLabelTextAndNextButtonText()
        setupDescLabelText(seconds: remainedSeconds)
        startTimer()
        addDescriptionLabelGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tfOne.becomeFirstResponder()
    }
    
        
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }
    
    //MARK: - IBActions
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let codeArray = [tfOne.text, tfTwo.text, tfThree.text, tfFour.text]
        let codeText = codeArray.compactMap{ $0 }.reduce("", +)
        guard codeText != "", codeText.count == 4 else { return }
        interactor.sendConfirmRequest(codeText)
    }
    
    
    //MARK: - Methods
    
    func setup(phoneNumber: String, rawPhoneNumber: String) {
        self.phoneNumber = phoneNumber
        self.rawPhoneNumber = rawPhoneNumber
    }
    
    private func setupTopLabelTextAndNextButtonText() {
        topLabel.text = ConfirmAuthViewControllerTexts.topLabelText
        nextButton.setTitle(CustomButtonsTitles.sendButtonTitle, for: .normal)
    }
    
    private func setupDescLabelText(seconds: Int) {
        self.descriptionLabel.text = ConfirmAuthViewControllerTexts.descriptionLabelText.setDescription(for: seconds, and: self.phoneNumber ?? "")
        self.descriptionLabel.setAttributedText(ConfirmAuthViewControllerTexts.attributedText(for: seconds))
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
                nextButton.setActive()
            default:
                break
                
            }
            
        } else if textField.text!.isEmpty {
            nextButton.setInActive()
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
        
        let range = (text as NSString).range(of: ConfirmAuthViewControllerTexts.resendText)
        
        if gesture.didTapAttributedTextInLabel(label: descriptionLabel, inRange: range) {
            interactor.sendRegistrationRequest()
            remainedSeconds = ConfirmAuthIntData.timerSeconds.rawValue
            startTimer()
        }
    }
}

//MARK: - ConfirmAuthViewProtocol
extension ConfirmAuthViewController: ConfirmAuthViewProtocol {
    func showMapViewController() {
        DispatchQueue.main.async {
            let mapVC = self.storyboard?.instantiateViewController(identifier: ViewControllers.MapViewController.rawValue) as! MapViewController
            self.navigationController?.pushViewController(mapVC, animated: true)
            
        }
    }
}
