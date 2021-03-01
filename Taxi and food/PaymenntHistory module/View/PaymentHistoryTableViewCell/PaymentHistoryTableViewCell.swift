//
//  PaymentHistoryTableViewCell.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 27.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PaymentHistoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    @IBOutlet weak var paymentNumberLabel: UILabel!
    
    @IBOutlet weak var cardNumberLabel: UILabel!
    
    @IBOutlet weak var sumLabel: UILabel!
    
    @IBOutlet weak var parentView: UIView!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cardImageView.isHidden = false
        self.cardNumberLabel.isHidden = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.parentView.layer.masksToBounds = false

        self.parentView.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.parentView.layer.shadowOpacity = Float(PaymentHistoryCellViewLayer.shadowOpacity.rawValue)
        self.parentView.layer.shadowRadius = PaymentHistoryCellViewLayer.shadowRadius.rawValue
        self.parentView.layer.shadowOffset = CGSize(width: PaymentHistoryCellViewLayer.shadowOffsetHeightAndWidth.rawValue,
                                                    height: PaymentHistoryCellViewLayer.shadowOffsetHeightAndWidth.rawValue)
               
    }
    
    func setupCell(by data:PaymentsHistoryResponseData) {
        self.sumLabel.text = String(data.paid) + PaymentHistoryViewControllerTexts.rubText
        self.paymentNumberLabel.text = PaymentHistoryViewControllerTexts.paymentText + String(data.order)
        guard let paymentCard = data.paymentCard  else {
            self.cardImageView.isHidden = true
            self.cardNumberLabel.isHidden = true
            return
        }
        self.cardNumberLabel.text = data.paymentCard?.number
        switch PaymentMethod.getPaymentMetod(from: paymentCard.system) {
        
        case .master:
            self.cardImageView.image = UIImage(named: CustomImagesNames.mastercardIcon.rawValue)
        case .visa:
            self.cardImageView.image = UIImage(named: CustomImagesNames.visaIcon.rawValue)
        case .unknown:
            self.cardImageView.isHidden = true
        }
    }
}
