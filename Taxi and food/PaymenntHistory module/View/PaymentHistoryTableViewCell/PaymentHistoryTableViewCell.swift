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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.parentView.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.parentView.layer.shadowOpacity = Float(PaymentHistoryCellViewLayer.shadowOpacity.rawValue)
        self.parentView.layer.shadowRadius = PaymentHistoryCellViewLayer.shadowRadius.rawValue
        self.parentView.layer.shadowOffset = CGSize(width: PaymentHistoryCellViewLayer.shadowOffsetHeightAndWidth.rawValue,
                                         height: PaymentHistoryCellViewLayer.shadowOffsetHeightAndWidth.rawValue)
        self.parentView.layer.masksToBounds = false
    }
    
}
