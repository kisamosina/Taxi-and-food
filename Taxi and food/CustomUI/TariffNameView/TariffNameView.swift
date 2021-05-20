//
//  TariffNameView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

@IBDesignable class TariffNameView: UIView {
    
    @IBInspectable var tariffName: String? {
        get { return tariffNameLabel.text}
        set {
            tariffNameLabel.text = newValue
            setBackGroundColor()
        }
    }
    
    private var tariffNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: TariffNameViewSizes.labelFontSize)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = bounds.height/2
    }
    
    private func setBackGroundColor() {
        guard let tariffName = tariffName else {
            backgroundColor = Colors.lightGrey.getColor()
            return }
        
        switch tariffName {
        case "Standart":
            backgroundColor = Colors.tariffGreen.getColor()
        case "Premium":
            backgroundColor = Colors.tariffPurple.getColor()
        case "Business":
            backgroundColor = Colors.tariffGold.getColor()
        default:
            backgroundColor = Colors.tariffGold.getColor()
        }
    }
    
    public func bindTariff(tariffName: String) {
        self.tariffName = tariffName
    }
    
    private func setupConstraints() {
        addSubview(tariffNameLabel)
        tariffNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        tariffNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        tariffNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
