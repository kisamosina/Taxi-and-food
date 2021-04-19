//
//  PointsSmallView.swift
//  Taxi and food
//
//  Created by mac on 18/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PointsSmallView: UIView {

    @IBOutlet var youHaveLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var spendAllButton: MainBottomButton!
    @IBOutlet var otherAmountButton: UIButton!
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func initSubviews() {
        self.loadFromNib(nibName: PointsSmallViewStringData.nibName.rawValue)
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        self.spendAllButton.setupAs(.spendAllPoints)
        self.otherAmountButton.setTitle(PointsSmallViewTexts.otherAmountButtonTitle, for: .normal)
        self.youHaveLabel.text = "У вас баллов"
        self.setupConstraints()
         
    }
    
    //Points show in other times
    public func setupPoints(_ pointsData: PointsResponseData) {
        
        let pointsString = String(pointsData.credit)
        let text = TransitionBottomViewTexts.youHaveNPointsText.insert(text: pointsString)
        self.youHaveLabel.text = text
        self.youHaveLabel.setBoldAndOrange(pointsString + " " + TransitionBottomViewTexts.youHaveNPointsText.selectedSuffixText())
        
        self.spendAllButton.setupAs(.spendAllPoints)
        self.otherAmountButton.setTitle(PointsSmallViewTexts.otherAmountButtonTitle, for: .normal)
        

    }
}

