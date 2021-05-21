//
//  TaxiOrderStatusView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 21.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class TaxiOrderStatusView: CustomBottomView {
    
    var mode: TaxiOrdeStatusViewModes!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusDescriptionLabel: UILabel!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var stateNumberView: StateNumberView!
    @IBOutlet weak var callLabel: UILabel!
    @IBOutlet weak var willbeSoonLabel: UILabel!
    @IBOutlet weak var callButton: MapRoundButton!
    @IBOutlet weak var willBeSoonStackView: UIStackView!
    @IBOutlet weak var willBeSoonButton: MapRoundButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubViews()
    }
    
    override func initSubViews() {
        super.initSubViews()
        self.loadFromNib(nibName: String(describing: TaxiOrderStatusView.self))
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        self.containerView.backgroundColor = .clear
        statusDescriptionLabel.isHidden = true
        willBeSoonStackView.isHidden = true
        bind(mode: .waiting)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    func bind(mode: TaxiOrdeStatusViewModes) {
        self.mode = mode
        callLabel.setText(text: TaxiOrderStatusViewTexts.call, of: .normalBlack(12))
        willbeSoonLabel.setText(text: TaxiOrderStatusViewTexts.willBeSoon, of: .normalBlack(12))
        carNameLabel.setText(text: "Белый Opel Astra")
        stateNumberView.stateNumber = "К 660 АК"
        stateNumberView.regionNumber = "716"
        
        switch mode {
        
        case .onWay:
            statusLabel.setText(text: TaxiOrderStatusViewTexts.alreadyOnWay, of: .headerSemiBold(26))
        case .almostThere:
            statusLabel.setText(text: TaxiOrderStatusViewTexts.almostThere, of: .headerSemiBold(26))
        case .waiting:
            statusLabel.setText(text: TaxiOrderStatusViewTexts.waitingForYou, of: .boldOrange(26))
            willBeSoonStackView.isHidden = false
        case .waitingBegin:
            statusLabel.setText(text: TaxiOrderStatusViewTexts.waiting, of: .headerSemiBold(26))
            statusDescriptionLabel.setText(text: TaxiOrderStatusViewTexts.freeWaitingDescription, of: .normalGrey(12))
            statusDescriptionLabel.isHidden = false
            
        }
    }
}
