//
//  TransitionBottomView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 09.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class TransitionBottomView: UIView {
    
    //MARK: - Properties
    
    weak var delegate: TransitionBottomViewDelegate?
    private var viewType: TransitionBottomViewTypes!
    
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
        self.delegate?.mainButtonTapped(for: self.viewType)
    }
    
    @IBAction func auxButtonTapped(_ sender: UIButton) {
        self.delegate?.auxButtonTapped(for: self.viewType)
    }
    
    @IBAction func userHasSwipedDown(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            self.delegate?.userHasSwipedDown(for: self.viewType)
        }
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
        self.setupLabels()
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
    
    //CardApprovement view
    
    private func cardApprovementSetup(cardNumber: String) {
        self.secondTitleLabel.isHidden = true
        self.firstTitleLabel.text = TransitionBottomViewTexts.approvementTitle
        
        self.descriptionLabel.text = TransitionBottomViewTexts.approvementDescription.insert(text: cardNumber)
        self.descriptionLabel.setBoldAndBlack(cardNumber)
        self.mainBottomButton.setupAs(.approve)
        self.mainBottomButton.setActive()
        self.auxButton.setupAs(type: .cancel)
    }
    
    //Points show in first time
    
    private func setupWhenFirstTimePointsShow(_ pointsData: PointsResponseData) {
        self.firstTitleLabel.text = TransitionBottomViewTexts.congratulationText
        self.firstTitleLabel.setBold(TransitionBottomViewTexts.congratulationText)
        let pointsString = String(pointsData.credit)
        let text = TransitionBottomViewTexts.youHaveNPointsText.insert(text: pointsString)
        self.secondTitleLabel.text = text
        self.secondTitleLabel.setBoldAndOrange(pointsString + " " + TransitionBottomViewTexts.youHaveNPointsText.selectedSuffixText())
        self.descriptionLabel.text = TransitionBottomViewTexts.shortPointsDescription
        self.mainBottomButton.setupAs(.newOrder)
        self.auxButton.setupAs(type: .about)
        UserDefaults.standard.storeIsNotFirstTimePointsUsing(true)
    }
    
    //Points show in other times
    private func setupWhenPointsShow(_ pointsData: PointsResponseData) {
        self.firstTitleLabel.isHidden = true
        let pointsString = String(pointsData.credit)
        let text = TransitionBottomViewTexts.youHaveNPointsText.insert(text: pointsString)
        self.secondTitleLabel.text = text
        self.secondTitleLabel.setBoldAndOrange(pointsString + " " + TransitionBottomViewTexts.youHaveNPointsText.selectedSuffixText())
        self.descriptionLabel.isHidden = true
        self.mainBottomButton.setupAs(.newOrder)
        self.auxButton.setupAs(type: .about)
    }
    
    //LogOut View
    private func setupWhenLogout() {
        self.firstTitleLabel.text = TransitionBottomViewTexts.logoutTitle
        self.firstTitleLabel.textColor = Colors.redTextColor.getColor()
        self.secondTitleLabel.isHidden = true
        self.descriptionLabel.isHidden = true
        self.mainBottomButton.setupAs(.logOut)
        self.auxButton.setupAs(type: .cancel)
    }
    
    public func setupAs(type: TransitionBottomViewTypes) {
        
        self.viewType = type
        
        switch type {
        
        case .cardApprovement (let cardNumber):
            self.cardApprovementSetup(cardNumber: cardNumber)
        case .pointsFirstTime(let pointsData):
            self.setupWhenFirstTimePointsShow(pointsData)
        case .points(let pointsData):
            self.setupWhenPointsShow(pointsData)
        case .logout:
            self.setupWhenLogout()
        }
    }
    
    
}
