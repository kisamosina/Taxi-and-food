//
//  PersonalDataBottomView.swift
//  Taxi and food
//
//  Created by mac on 23/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PersonalDataBottomView: UIView {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var topView: UIView!
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var mainButton: MainBottomButton!
    @IBOutlet var textfield: UITextField!
    
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
        self.setUpWhenPersonalDataEnter()
    }
    
    func setUpWhenPersonalDataEnter() {
//        self.textfield.placeholder =
        self.mainButton.setupAs(.approve)
        self.mainButton.setActive()
       
    }
    
    
    
}
