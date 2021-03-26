//
//  TipAddressView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 26.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class TipAddressView: UIView {

    //MARK: - IBOutlets
    
    @IBOutlet weak var tipImageView: UIImageView!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet var containerView: UIView!
    
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
    
    
    @IBAction func userHasTappedView(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.removeFromSuperview()
        }
    }
    
    //MARK: - Methods
    
    private func initSubviews() {
        
        self.loadFromNib(nibName: TipAddressViewStringData.nibName.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        self.tipLabel.text = TipAddressViewTexts.tipText
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tipImageView.clipsToBounds = true
        self.tipImageView.layer.cornerRadius = tipImageView.frame.height/2
    }
}
