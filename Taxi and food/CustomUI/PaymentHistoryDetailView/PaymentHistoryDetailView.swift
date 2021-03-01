//
//  PaymentHistoryDetailView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 01.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PaymentHistoryDetailView: UIView {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var paymentImage: UIImageView!
    
    @IBOutlet weak var cartNumberLabel: UILabel!
    
    @IBOutlet weak var paymentNumberLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var emailButton: MainBottomButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    class func instanceFromNib() -> UIView {
        
        let bundle = Bundle(for: self)
        
        return UINib(nibName: PaymentHistoryIds.PaymentHistoryDetailView.rawValue, bundle: bundle).instantiate(withOwner: self, options: nil)[0] as! UIView
        }
}
