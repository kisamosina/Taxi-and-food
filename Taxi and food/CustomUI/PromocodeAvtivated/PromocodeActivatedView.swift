//
//  PromocodeActivated.swift
//  Taxi and food
//
//  Created by mac on 15/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PromocodeActivatedView: UIView {
    
//    weak var delegate: PromocodeActivatedViewDelegate!

    @IBOutlet var containerView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    
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
            self.loadFromNib(nibName: PromocodeActivatedViewStringData.nibName.rawValue)
            
            self.containerView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(containerView)
            
            self.titleLabel.text = PromocodeActivatedTexts.titleText
            self.setupConstraints()
             
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
