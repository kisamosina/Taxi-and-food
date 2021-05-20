//
//  TaxiHasFoundView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.05.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import Foundation
import UIKit

class TaxiHasFoundView: CustomBottomView {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tripTimeView: TopInfoView!
    @IBOutlet weak var addressFromLabel: UILabel!
    @IBOutlet weak var addressToLabel: UILabel!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var tariffNameView: TariffNameView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet weak var feedTime: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var approveButton: MainBottomButton!
    @IBOutlet weak var cancelButton: AuxiliaryButton!
    
    //MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubViews()
    }
    
    //MARK: - IBActions
    
    @IBAction func approveButtonTapped(_ sender: MainBottomButton) {
    }
    
    @IBAction func cancelButtonTapped(_ sender: AuxiliaryButton) {
    }
    
    
    //MARK: - Methods
    
    override func initSubViews() {
        super.initSubViews()
        self.loadFromNib(nibName: String(describing: TaxiHasFoundView.self))
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        containerView.backgroundColor = .clear
        anchorView.backgroundColor = Colors.whiteTransparent.getColor()
        bind()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

    public func bind() {
        tripTimeView.setupTitle("≈15 мин")
        addressFromLabel.setText(text: "Садовая-Триумфальная, 24", of: .normalGrey())
        addressToLabel.setText(text: "Тверская, 13", of: .normalGrey())
        carNameLabel.setText(text: "Белый Opel Astra")
        tariffNameView.bindTariff(tariffName: "Standart")
        driverLabel.text = "\(TaxiHasFoundViewTexts.driver) Анатолий (id: 23-87)"
        driverLabel.setColorForText(TaxiHasFoundViewTexts.driver, color: Colors.fontGrey.getColor())
        feedTime.text = "\(TaxiHasFoundViewTexts.feedTime) 3 минуты"
        feedTime.setColorForText(TaxiHasFoundViewTexts.feedTime, color: Colors.fontGrey.getColor())
        priceLabel.text = "100 руб"
        approveButton.setupAs(.approve)
        approveButton.setActive()
        cancelButton.setupAs(type: .cancel)
    }
    
}
