//
//  PersonalDataBottomView.swift
//  Taxi and food
//
//  Created by mac on 23/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PersonalDataBottomView: UIView {
    
    weak var delegate: PersonalDataViewDelegate?
    
    //MARK: - IBOutlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var topView: UIView!
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var mainButton: MainBottomButton!

    @IBOutlet var textfield: UITextField!
    
    var text: String? {
        get {
            return textfield.text
        }
        set {
            textfield.text = newValue
        }
    }
    
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
        
        self.loadFromNib(nibName: PersonalDataBottomViewStringData.nibName.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
//        self.setUpWhenPersonalDataEnter()
        self.mainButton.setupAs(.approve)
//        self.textfield.becomeFirstResponder()
        self.textfield.addTarget(self, action: #selector(buttonActivate), for: .editingChanged)
        self.mainButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setPlaceholder(cellPlaceholder: String) {
        self.textfield.placeholder = cellPlaceholder
    }
    
    @objc private func buttonActivate() {
        self.mainButton.setActive()
    }

    
    @objc func buttonTapped() {
        print("entered user's text")
        print(text)
        self.delegate?.approveDataButtonTapped(text ?? "")
        
    }
    
    
}
