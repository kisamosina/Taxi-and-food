//
//  DiscountsButtonView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 27.04.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

@IBDesignable class DiscountsButtonView: UIView {
    
    //MARK: - Properties
    
    private var shadowLayer: CAShapeLayer!
    
    @IBInspectable var title: String? {
        get { self.discountTypeLabel.text }
        set { self.discountTypeLabel.text = newValue }
    }
    
    @IBInspectable var discountImage: UIImage? {
        get { self.discountTypeImageView.image }
        set { self.discountTypeImageView.image = newValue }
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var discountTypeImageView: UIImageView!
    @IBOutlet weak var discountTypeLabel: UILabel!
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }
        
    //MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = DiscountsButtonViewSizeData.cornerRadius.rawValue
        
        if shadowLayer == nil {
                    shadowLayer = CAShapeLayer()
                    shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 15).cgPath
                    shadowLayer.fillColor = UIColor.white.cgColor
                    shadowLayer.shadowColor = Colors.shadowColor.getColor().cgColor
                    shadowLayer.shadowPath = shadowLayer.path
                    shadowLayer.shadowOffset = CGSize(width: DiscountsButtonViewSizeData.shadowOffsetWidth.rawValue, height: DiscountsButtonViewSizeData.shadowOffsetHeight.rawValue)
                    shadowLayer.shadowOpacity = Float(DiscountsButtonViewSizeData.shadowOpacity.rawValue)
                    shadowLayer.shadowRadius = DiscountsButtonViewSizeData.shadowRadius.rawValue

                    layer.insertSublayer(shadowLayer, at: 0)
                    //layer.insertSublayer(shadowLayer, below: nil) // also works
                }
        
        
    }
    
    private func initSubviews() {
        
        self.loadFromNib(nibName: DiscountsButtonViewStringData.nibFileName.rawValue)
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
}
