//
//  TimeToDestinationView.swift
//  Taxi and food
//
//  Created by mac on 07/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

@IBDesignable
class TimeToDestinationView: UIView {
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentGradientView: GradientView!
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }
    
        private func initSubviews() {
            self.loadFromNib(nibName: TimeToDestinationViewStringData.nibName.rawValue)
            
            self.containerView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(containerView)
            
            self.titleLabel.text = TimeToDestinationViewTexts.labelTitle
            self.titleLabel.textColor = .white
            self.setupConstraints()
             
        }
    
    //MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Layout setup
        self.contentGradientView.layer.cornerRadius = TimeToDestinationViewSizes.cornerRadius.rawValue
        self.contentGradientView.layer.masksToBounds = false
        
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
