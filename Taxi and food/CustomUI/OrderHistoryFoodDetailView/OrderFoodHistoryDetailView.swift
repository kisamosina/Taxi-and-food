//
//  OrderFoodHistoryDetailView.swift
//  Taxi and food
//
//  Created by mac on 29/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class OrderFoodHistoryDetailView: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var orderListLabel: UILabel!
    @IBOutlet var paymentNumberLabel: UILabel!
    @IBOutlet var orderTypeLabel: UILabel!
    @IBOutlet var storeLabel: UILabel!
    @IBOutlet var courierLabel: UILabel!
    @IBOutlet var toLabel: UILabel!
    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var sumLabel: UILabel!
    
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
        let nib = UINib(nibName: OrderHistoryIds.OrderFoodHistoryDetailView.rawValue, bundle: bundle)
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
        
       
        
        let unixDate = data.updatedAt
        let date = Date(timeIntervalSince1970: unixDate)
        let dateString = DateFormatter().getDateByDay(date: date)
        self.dateLabel.text = dateString
        
        self.orderTypeLabel.text = OrderHistoryViewControllerTexts.typeFood
        self.foodImage.image = UIImage(named: CustomImagesNames.foodType.rawValue)
        self.storeLabel.text = ""
        self.courierLabel.text = OrderHistoryDetailViewTexts.courier + String(data.courier?[0].name ?? "")
        self.toLabel.text = OrderHistoryDetailViewTexts.store + String(data.to)
        print("data.products")
        print(data.products)
        
        guard let products = data.products else { return }
        
        var arrayOfProducts: [String] = []
        var productDescription = String()
        
        for product in products {
            let name = product.name
            let composition = product.composition
            let unit = product.unit
            
            productDescription = name + " " + composition + " " + unit
            arrayOfProducts.append(productDescription)

        }
        
        for descr in arrayOfProducts {
            
            self.orderListLabel.text = OrderHistoryDetailViewTexts.orderList + descr
            
        }
        
        
        self.sumLabel.text = String(data.forPayment) + OrderHistoryViewControllerTexts.rubText
        
        guard let payment = data.payment else { return }
        
       
            self.paymentNumberLabel.text = OrderHistoryDetailViewTexts.payment + String(payment.orderId)
            
        
        
        
    }

}
