//
//  PromocodeEnterViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 23.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol PromocodeEnterViewProtocol: class {
    var interactor: PromocodeEnterInteractorProtocol! { get set }
    func setupLabelError(text: String)
}

class PromocodeEnterViewController: UIViewController {
    
    //MARK: - Properties
    var interactor: PromocodeEnterInteractorProtocol!
    
    var textEnterView: TextEnterView = {
        let view = TextEnterView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var bottomConstraint:NSLayoutConstraint!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = PromocodeEnterInteractor(view: self)
        self.navigationItem.title = PromocodeEnterViewControllerTexts.vcTitle
        self.setupTextView()
        self.addKeyboardWillShowObserver()
        self.textEnterView.delegate = self
    }
    
    //MARK: - Methods
    private func setupTextView() {
        self.view.addSubview(textEnterView)
        
        
        bottomConstraint = self.textEnterView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            self.bottomConstraint,
            self.textEnterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.textEnterView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.textEnterView.heightAnchor.constraint(equalToConstant: TextEnterViewSize.height.rawValue)
            
        ])
    }
    
    private func addKeyboardWillShowObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    
    @objc private func keyBoardWillAppear(notification: NSNotification) {
        keyboardWillShow(constraint: bottomConstraint, notification: notification)
    }
}

//MARK: - TextEnterViewDelegate
extension PromocodeEnterViewController: TextEnterViewDelegate {
    func approveButtonTapped(_ text: String) {
        
        self.interactor.requestPromocodeActivate(code: text)
    }
    
    
}

//MARK: - PromocodeEnterViewProtocol

extension PromocodeEnterViewController: PromocodeEnterViewProtocol {
    func setupLabelError(text: String) {
        DispatchQueue.main.async {
            self.textEnterView.label.isHidden = false
            self.textEnterView.label.text = text
        }
    }
    
    
}
