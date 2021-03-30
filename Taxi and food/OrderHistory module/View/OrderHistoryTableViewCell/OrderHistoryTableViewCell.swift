//
//  OrderHistoryTableViewCell.swift
//  Taxi and food
//
//  Created by mac on 26/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class OrderHistoryTableViewCell: UITableViewCell {
    
    var orderHistoryData: OrderHistoryResponseData!
    var cellType: OrderType!
    
    @IBOutlet var parentView: UIView!
    @IBOutlet var sumLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var serviceLabel: UILabel!
    @IBOutlet var orderImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.orderImageView.isHidden = false
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
    
    func setUpCell(by data: OrderHistoryResponseData) {
//        data
        self.orderHistoryData = data
//        date
        let unixDate = data.updatedAt
        let date = Date(timeIntervalSince1970: unixDate)
        let dateString = DateFormatter().getDateByDay(date: date)
        self.dateLabel.text = dateString
        
        
        let orderType = data.type

        switch OrderType.getOrderType(from: orderType) {
        case .food:
            self.orderImageView.image = UIImage(named: CustomImagesNames.foodType.rawValue)
            self.typeLabel.text = OrderHistoryViewControllerTexts.typeFood
            self.serviceLabel.text = OrderHistoryViewControllerTexts.typeFoodLabel
            self.cellType = .food
            
        case .taxi:
            self.orderImageView.image = UIImage(named: CustomImagesNames.taxiType.rawValue)
            self.typeLabel.text = OrderHistoryViewControllerTexts.typeTaxi
            self.serviceLabel.text = OrderHistoryViewControllerTexts.typeTaxiLabel
            self.cellType = .taxi
        case .unknown:
            self.orderImageView.isHidden = true
        }

        self.sumLabel.text = String(data.forPayment) + OrderHistoryViewControllerTexts.rubText


    }
    
}
