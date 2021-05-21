//
//  StateNumberView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 21.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

@IBDesignable class StateNumberView: UIView {
    
    @IBInspectable var stateNumber: String? {
        get { numberLabel.text }
        set { numberLabel.text = newValue}
    }
    
    @IBInspectable var regionNumber: String? {
        get { regionLabel.text }
        set {
            if let newValue = newValue, newValue.count < 4, let _ = Int(newValue) {
                regionLabel.text = newValue
            }
        }
    }
    
    @IBInspectable var flagIcon: UIImage? {
        get { flagImageView.image }
        set { flagImageView.image = newValue}
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubViews()
    }
    
    func initSubViews() {
        self.loadFromNib(nibName: String(describing: StateNumberView.self))
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        self.containerView.backgroundColor = Colors.dullGrey.getColor()
        
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
