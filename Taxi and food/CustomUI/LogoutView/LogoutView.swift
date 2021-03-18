//
//  LogoutView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 05.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class LogoutView: UIView {
    
    //MARK: - Properties
    
    weak var delegate: LogoutViewDelegate?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var logOutLabel: UILabel!
    @IBOutlet weak var logOutButton: MainBottomButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }

    //MARK: - IBActions
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.delegate?.cancelButtonTapped()
    }
    
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
            
        switch sender.direction {
        case .down:
            self.delegate?.swipeDown()
        default:
            break
        }
    }
    
    
    //MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        self.topView.clipsToBounds = true
        self.topView.layer.cornerRadius = self.topView.frame.height/2
        self.mainView.clipsToBounds = true
        self.mainView.layer.cornerRadius = LogoutViewSizes.mainViewCornerRadius.rawValue
    }
    
    private func initSubviews() {
        
        self.loadFromNib(nibName: LogoutViewStringData.nibName.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        self.logOutButton.setupAs(.logOut)
//        self.logOutLabel.text = label
//        self.cancelButton.setTitle(buttonTittle, for: .normal)
        self.logOutLabel.text = LogoutViewTexts.logoutLabelText
        self.cancelButton.setTitle(LogoutViewTexts.cancelButtonTitle, for: .normal)
    }
    
    private func setupConstraints() {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: containerView.topAnchor),
                self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])
        }
}
