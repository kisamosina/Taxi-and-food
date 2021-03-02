//
//  PaymentHistoryDetailView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 01.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol PaymentHistoryDetailViewDelegate {
    
}

class PaymentHistoryDetailView: UIView {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var paymentImage: UIImageView!
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var cartNumberLabel: UILabel!
    
    @IBOutlet weak var paymentNumberLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var emailButton: MainBottomButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }

    private func initSubviews() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: PaymentHistoryIds.PaymentHistoryDetailView.rawValue, bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        self.emailButton.setupAs(.sendEmail)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    func setupView(by data:PaymentsHistoryResponseData) {
        
        let dateString = DateFormatter().getDateWithPoints(date: Date())
        
        self.dateLabel.text = dateString
        self.costLabel.text = String(data.paid) + PaymentHistoryViewControllerTexts.rubText
        self.paymentNumberLabel.text = PaymentHistoryViewControllerTexts.paymentText + String(data.order)
        self.descriptionLabel.text = PaymentHistoryViewControllerTexts.description
        guard let paymentCard = data.paymentCard  else {
            self.paymentImage.isHidden = true
            self.cartNumberLabel.isHidden = true
            return
        }
        self.cartNumberLabel.text = data.paymentCard?.number
        switch PaymentMethod.getPaymentMetod(from: paymentCard.system) {
        
        case .master:
            self.paymentImage.image = UIImage(named: CustomImagesNames.mastercardIcon.rawValue)
        case .visa:
            self.paymentImage.image = UIImage(named: CustomImagesNames.visaIcon.rawValue)
        case .unknown:
            self.paymentImage.isHidden = true
        }
    }

    
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        
    }
}
