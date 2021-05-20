//
//  EstimatedTimeView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 28.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

@IBDesignable class TopInfoView: UIView {

    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = TopInfoViewSizesData.cornerRadius.rawValue
    }
    
    private func initSubviews() {
        self.loadFromNib(nibName: String(describing: TopInfoView.self))
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
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
    
    public func setupTitle(_ title: String) {
        self.titleLabel.text = title
    }
}
