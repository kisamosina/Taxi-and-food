//
//  ServiceViewController.swift
//  Taxi and food
//
//  Created by mac on 12/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit
import Foundation

class ServiceViewController: UIViewController {
    
    //MARK: - Properties
    
    var placeholderText: String?

    @IBOutlet var fillInTextView: ProblemTextView!
    
    @IBOutlet var nextButton: MainBottomButton!
    
    @IBOutlet var nextButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillInTextView.delegate = self
        
        addKeyboardWillShowObserver()
        addKeyboardWillHideObserver()
        setupNextButton()
        setUpfillInTextViewPlaceholderText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: nil, action: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        
    }
    @objc private func keyboardWillAppear(notification: NSNotification) {
        keyboardWillShow(constraint: nextButtonBottomConstraint, notification: notification)

    }

    @objc private func keyboardWillDisappear(notification: NSNotification) {
        keyboardWillHide(constraint: nextButtonBottomConstraint, notification: notification)

    }
    
//    MARK: - Methods
    
    private func addKeyboardWillShowObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func addKeyboardWillHideObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setUpfillInTextViewPlaceholderText() {
        self.placeholderText = ServiceViewControllerTextData.fillInPlaceholderText
        self.fillInTextView.textColor = UIColor.lightGray
        self.fillInTextView.text = placeholderText

    }

}


extension ServiceViewController: UITextViewDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == placeholderText {
            textView.textColor = .black
            textView.text = ""
        }
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
        }
    }
}


//FIX ME:
extension ServiceViewController {
    func setupNextButton() {
        self.nextButton.setActive()
    }
}
