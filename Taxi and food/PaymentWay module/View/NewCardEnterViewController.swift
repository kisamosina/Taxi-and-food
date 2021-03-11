//
//  NewCardEnterViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 08.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class NewCardEnterViewController: UIViewController {
    
    //MARK: - Properties
    
    internal var interactor: NewCardEnterInteractorProtocol!

    //MARK: - IBOutlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var cardEnterView: CardEnterView!
        
    @IBOutlet weak var cardEnterViewYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var approveCardView: TransitionBottomView!
    
    @IBOutlet weak var approveCardViewBottomConstraint: NSLayoutConstraint!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = NewCardEnterInteractor(view: self)
        self.addKeyboardObserver()
        self.cardEnterView.delegate = self
        self.cardEnterView.cardNumberTextField.becomeFirstResponder()
        self.approveCardView.alpha = 0

    }
    
    //MARK: - Methods
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillAppear(notification: NSNotification) {
        self.keyboardWillShow(constraint: cardEnterViewYConstraint, notification: notification)
    }
    
    @objc func keyboardWillDisappear(notification: NSNotification) {
        self.keyboardWillHide(constraint: cardEnterViewYConstraint, notification: notification)
    }

}

//MARK: - CardEnterViewDelegate
extension NewCardEnterViewController: CardEnterViewDelegate {
    
    func callApproveView() {
        self.cardEnterView.alpha = 0
            let window = UIApplication.shared.windows[0]
            let bottomPadding = window.safeAreaInsets.bottom
        self.approveCardView.setupAs(type: .cardApprovement("4487452445282054"))
        self.approveCardViewBottomConstraint.constant = 0 - bottomPadding
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[weak self] in
                        self?.view.layoutIfNeeded()
                        self?.approveCardView.alpha = 1
                       },
                       completion: nil)
    }
    
    
    func catchCardData(cardNumber: String, expirationDate: String, cvv: String) {
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder),
                        to: nil, from: nil, for: nil)
        self.callApproveView()
//        self.interactor.makeRequestFor(cardNumber: cardNumber, expirationDate: expirationDate, cvv: cvv)
    }

        
}

//MARK: - NewCardEnterViewProtocol

extension NewCardEnterViewController: NewCardEnterViewProtocol { }
