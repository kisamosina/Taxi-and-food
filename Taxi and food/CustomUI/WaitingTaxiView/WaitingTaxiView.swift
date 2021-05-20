//
//  WaitingTaxiView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 18.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class WaitingTaxiView: CustomBottomView {

    weak var delegate: WaitingTaxiViewDelegate?
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cancelButton: AuxiliaryButton!
    @IBOutlet weak var emmiterView: EmmiterView!
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubViews()
    }
    
    //MARK: - Methods
    
    override func initSubViews() {
        super.initSubViews()
        self.loadFromNib(nibName: String(describing: WaitingTaxiView.self))
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        containerView.backgroundColor = .clear
        anchorView.isHidden = true
        stateLabel.textColor = Colors.taxiOrange.getColor()
        stateLabel.text = WaitingTaxiViewTexts.stateSearchAnOption
        cancelButton.setupAs(type: .cancel)
        emmiterView.startAnimating()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    @IBAction func cancelButtonTapped(_ sender: AuxiliaryButton) {
        emmiterView.stopAnimating()
        delegate?.cancelButtonTapped()
    }
}
