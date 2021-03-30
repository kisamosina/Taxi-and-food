//
//  OrderHistoryDetailView.swift
//  Taxi and food
//
//  Created by mac on 29/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class OrderHistoryDetailView: UIView {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var orderTypeLabel: UILabel!
    @IBOutlet var fromLabel: UILabel!
    @IBOutlet var toLabel: UILabel!
    @IBOutlet var driverLabel: UILabel!
    @IBOutlet var carLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var travelTimeLabel: UILabel!
    @IBOutlet var sumLabel: UILabel!
    @IBOutlet var paymentLabel: UILabel!
    @IBOutlet var tariffLabel: UILabel!
    
    @IBOutlet var taxiImage: UIImageView!
    
    @IBOutlet var containerView: UIView!
    

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
        let nib = UINib(nibName: OrderHistoryIds.OrderHistoryDetailView.rawValue, bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 14
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
    

    func setupView(by data: OrderHistoryResponseData) {
        
        print("data.tariff?.name")
        print(data.tariff?.name)
        guard let tariffame = data.tariff?.name else { return }
        self.tariffLabel.text = tariffame
        
        let unixDate = data.updatedAt
        let date = Date(timeIntervalSince1970: unixDate)
        let dateString = DateFormatter().getDateByDay(date: date)
        self.dateLabel.text = dateString
        self.orderTypeLabel.text = OrderHistoryViewControllerTexts.typeTaxi
        self.fromLabel.text = OrderHistoryDetailViewTexts.from + String(data.from ?? "")
        self.toLabel.text = OrderHistoryDetailViewTexts.to + String(data.to)
        self.driverLabel.text = OrderHistoryDetailViewTexts.driver + String(data.taxi?[0].driver ?? "")
        self.carLabel.text = OrderHistoryDetailViewTexts.car + String(data.taxi?[0].car ?? "")
        self.numberLabel.text = OrderHistoryDetailViewTexts.number + String(data.taxi?[0].number ?? "")
        
        self.travelTimeLabel.text = OrderHistoryDetailViewTexts.time + String(data.distance)
        self.sumLabel.text = String(data.forPayment) + OrderHistoryViewControllerTexts.rubText
        self.paymentLabel.text = OrderHistoryDetailViewTexts.payment
        self.taxiImage.image = UIImage(named: CustomImagesNames.taxiType.rawValue)
        
        guard let payment = data.payment else { return }
               
              
                   self.paymentLabel.text = OrderHistoryDetailViewTexts.payment + String(payment.orderId)
        
         
    }
}
