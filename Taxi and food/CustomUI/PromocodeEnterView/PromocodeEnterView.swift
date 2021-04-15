//
//  PromocodeEnterView.swift
//  Taxi and food
//
//  Created by mac on 15/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PromocodeEnterView: UIView {
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var topView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var promoTextField: UITextField!
    @IBOutlet var mainButton: MainBottomButton!
    
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }
    
    //MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Layout setup
        self.contentView.layer.cornerRadius = TransitionBottomViewSizes.cornerRadius.rawValue
        self.contentView.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.contentView.layer.shadowOpacity = Float(TransitionBottomViewSizes.shadowOpacity.rawValue)
        self.contentView.layer.shadowRadius = TransitionBottomViewSizes.cornerRadius.rawValue
        self.contentView.layer.shadowOffset = CGSize(width: TransitionBottomViewSizes.shadowOffsetWidth.rawValue,
                                                     height: TransitionBottomViewSizes.shadowOffsetWidth.rawValue)
        self.contentView.layer.masksToBounds = false
        self.topView.layer.cornerRadius = self.topView.frame.height/2
        self.topView.clipsToBounds = true
        
    }
    
    private func initSubviews() {
        self.loadFromNib(nibName: PromocodeEnterViewStringData.nibName.rawValue)
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.promoTextField.addBottomBorder(color: Colors.buttonBlue.getColor())
//        self.promoTextField.becomeFirstResponder()
        self.mainButton.setupAs(.approve)
        self.setupConstraints()

//        self.locationTextField.delegate = self
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
