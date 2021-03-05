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
    //General
    private var vcState: InactiveViewControllerStates!
    
    //For LogOut
    var logoutView: LogoutView!
    
    //For payment history detail case
    private var payDetailView: PaymentHistoryDetailView!
    private var rectOfCell: CGRect!
    private var paymentHistoryData: PaymentsHistoryResponseData!
    
    //MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.InactiveViewColor.getColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setView()
    }
    
    
    private func setView() {
        
        switch self.vcState {
        
        case .showPaymentHistoryDetailView:
            self.showPaymentHistoryDetailView(for: rectOfCell, and: paymentHistoryData)
        case .showLogoutView:
            self.showLogoutView()
        default:
            break
        }
    }
    
    @IBAction func userTapped(_ sender: UITapGestureRecognizer) {
        switch vcState {
            
        case .showPaymentHistoryDetailView:
            self.dismiss(animated: false, completion: nil)
        case .showLogoutView:
            self.hideLogoutView()
            
        default:
            break
        }
        
    }
}

//MARK: - When payment history detail case

extension InactiveViewController {
    
    // Show payment History detail view
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
        self.vcState = .showPaymentHistoryDetailView
        self.rectOfCell = rect
        self.paymentHistoryData = data
    }
}

//MARK: - When LogOut Case

extension InactiveViewController: LogoutViewDelegate {
    
    //Action on swipe down
    func swipeDown() {
        self.hideLogoutView()
    }
    
    
    //Action on cancel button tapped
    func cancelButtonTapped() {
        self.hideLogoutView()
    }
    
    //Show logout view
    private func showLogoutView() {
        
        let rect = CGRect(x: 0,
                          y: UIScreen.main.bounds.height,
                          width: UIScreen.main.bounds.width,
                          height: LogoutViewSizes.height.rawValue)
        self.logoutView = LogoutView(frame: rect)
        logoutView.alpha = 0
        self.view.addSubview(logoutView)
        self.logoutView.delegate = self
        
        //Animation
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.logoutView.alpha = 1
                        let window = UIApplication.shared.windows[0]
                        let bottomPadding = window.safeAreaInsets.bottom
                        self.logoutView.frame.origin.y = UIScreen.main.bounds.height - LogoutViewSizes.height.rawValue + bottomPadding
                       },
                       completion: nil)
    }
    
    //Hide logout view
    private func hideLogoutView() {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.logoutView.alpha = 0
                        self.logoutView.frame.origin.y = UIScreen.main.bounds.height
                       },
                       completion: {[unowned self] _ in
                        self.dismiss(animated: false, completion: nil)
                       })
        
    }
    
    func setLogoutState() {
        self.vcState = .showLogoutView
    }
}

