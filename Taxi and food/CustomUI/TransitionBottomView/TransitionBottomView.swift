//
//  TransitionBottomView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 09.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class TransitionBottomView: UIView {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainBottomButton: MainBottomButton!
    @IBOutlet weak var auxButton: AuxiliaryButton!
    
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
    
    @IBAction func mainBottomButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func auxButtonTapped(_ sender: UIButton) {
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
        
        self.loadFromNib(nibName: TransitionBottomViewStringData.nibName.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        self.mainBottomButton.setupAs(.logOut)
    }
    
    private func setupConstraints() {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: containerView.topAnchor),
                self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])
        }
    
    private func setupLabels() {
        self.descriptionLabel.font = .systemFont(ofSize: TransitionBottomViewSizes.descriptionLabelFontSize.rawValue)
        self.descriptionLabel.textColor = Colors.fontGrey.getColor()
    }
   
    public func setupAs(type: TransitionBottomViewTypes) {
        
        switch type {
        
        case .cardApproveMent:
            self.secondTitleLabel.isHidden = true
        }
    }
}
