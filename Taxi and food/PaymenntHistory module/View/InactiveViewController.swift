//
//  InactiveViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 03.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class InactiveViewController: UIViewController {
    
    //MARK: - Properties
    private var payDetailView: PaymentHistoryDetailView!
    private var rectOfCell: CGRect!
    private var data: PaymentsHistoryResponseData!
    
    //MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.InactiveViewColor.getColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showPaymentHistoryDetailView(for: rectOfCell, and: data)
    }
    
    private func showPaymentHistoryDetailView(for cell: CGRect, and data: PaymentsHistoryResponseData) {
        
        let rect = CGRect(x: cell.origin.x,
                          y: cell.origin.y,
                          width: PaymentHistoryDetailViewUIData.width.rawValue,
                          height: PaymentHistoryDetailViewUIData.height.rawValue)
        
        self.payDetailView = PaymentHistoryDetailView(frame: rect)
        self.payDetailView.alpha = 0
        self.payDetailView.setupView(by: data)
        self.view.addSubview(payDetailView)
        
        //Animation
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.payDetailView.alpha = 1
                        self.payDetailView.frame = CGRect(x: self.view.bounds.width/2 - PaymentHistoryDetailViewUIData.width.rawValue/2,
                                                          y: self.view.bounds.height/2 - PaymentHistoryDetailViewUIData.height.rawValue/2,
                                                          width: PaymentHistoryDetailViewUIData.width.rawValue,
                                                          height: PaymentHistoryDetailViewUIData.height.rawValue)
                       },
                       completion: nil)
    }
    
    func setCellRectAndDetailViewData(rect: CGRect, data: PaymentsHistoryResponseData) {
        self.rectOfCell = rect
        self.data = data
    }
    
    @IBAction func userTapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
    }
}
