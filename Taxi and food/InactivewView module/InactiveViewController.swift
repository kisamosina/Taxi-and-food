//
//  InactiveViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 03.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class InactiveViewController: UIViewController {
    
    typealias AnimationCompletion = (Bool) -> Void
    
    //MARK: - Properties
    
    //General
    private var vcState: InactiveViewControllerStates!
        
    private var closeCompletion: AnimationCompletion {
        return  { [weak self] _ in self?.dismiss(animated: false, completion: nil) }
    }
    
    weak var delegate: InactiveViewControllerDelegate?
    
    private var payDetailView: PaymentHistoryDetailView!
    private var orderDetailView: OrderHistoryDetailView!
    private var rectOfCell: CGRect!
    private var paymentHistoryData: PaymentsHistoryResponseData!
    private var orderHistoryData: OrderHistoryResponseData!
    private var transitionBottomView: TransitionBottomView!
    private var aboutPointsView: AboutPointsView!
    private var personalDataTransitionView: PersonalDataBottomView!
    private var keyboardHeight: CGFloat?
    private var personalDataViewPadding: CGFloat?
    
    //MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.InactiveViewColor.getColor()
        addKeyboardWillShowObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setView()
    }
    
    private func addKeyboardWillShowObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
       
    }

    @objc private func keyboardWillAppear(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let beginEnd = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        let beginFrameY = beginEnd?.origin.y ?? 0
        print("endFrameY")
        print(endFrameY)
        
        keyboardHeight = keyboardWillShowHeight(notification: notification)
        personalDataViewPadding = endFrameY

    }

    
    
    private func setView() {
        
        switch self.vcState {
        
        case .showPaymentHistoryDetailView:
            self.showPaymentHistoryDetailView(for: rectOfCell, and: paymentHistoryData)
            
        case .showOrderHistoryDetailView:
            self.showOrderHistoryDetailView(for: rectOfCell, and: orderHistoryData)
            
        case .showLogoutView:
            self.showLogoutView()
            
        case .showPointsView(let pointsData):
            self.showPointsView(pointsData)
        
        case .showDeleteAddressView:
            self.showDeleteAddressView()
            
        case .showEnterPersonalDataView:
            self.showEnterPersonalDataView()
            
        default:
            break
        }
    }
    
    @IBAction func userTapped(_ sender: UITapGestureRecognizer) {
        switch vcState {
        
        case .showPaymentHistoryDetailView:
            self.dismiss(animated: false, completion: nil)
        case .showOrderHistoryDetailView:
            self.dismiss(animated: false, completion: nil)
        case .showLogoutView:
            self.hideTransitionBottomView(completion: closeCompletion)
        case .showPointsView(_):
            self.dismiss(animated: false, completion: nil)
        case .showDeleteAddressView:
            self.dismiss(animated: false, completion: nil)
        case .showEnterPersonalDataView:
            self.dismiss(animated: false, completion: nil)
        default:
            break
        }
    }
    
    func setState(_ state: InactiveViewControllerStates) {
        self.vcState = state
    }
}

//MARK: - Transition View general methods

extension InactiveViewController {
    
    //Hide transition view
    private func hideTransitionBottomView(completion: AnimationCompletion? = nil) {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.transitionBottomView.alpha = 0
                        self.transitionBottomView.frame.origin.y = UIScreen.main.bounds.height
                       },
                       completion: completion)
        
    }
}

//MARK: - When enter personal data case

extension InactiveViewController {
    
    private func showEnterPersonalDataView() {
        
        
        
        let rect = CGRect(x: 0,
                          y: UIScreen.main.bounds.height,
                          width: UIScreen.main.bounds.width,
                          height: TextEnterViewSize.height.rawValue)
        
        self.personalDataTransitionView = PersonalDataBottomView(frame: rect)
        print("my height")
        print(personalDataTransitionView.frame.height)
        
//        self.personalDataTransitionView.
//        self.personalDataTransitionView.delegate = self
        self.personalDataTransitionView.alpha = 0
        self.view.addSubview(self.personalDataTransitionView)
        
        //Animation
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.personalDataTransitionView.alpha = 1

                        let window = UIApplication.shared.windows[0]
                        let bottomPaddingSafeArea = window.safeAreaInsets.bottom
                        guard let bottomPadding = self.personalDataViewPadding, let height = self.keyboardHeight else { return }
                        
                        
                        print("bottomPadding")
                        print(bottomPadding)
                        print(bottomPaddingSafeArea)
                        print("keyboardHeight")
                        print(height)
                        
                     
                        self.personalDataTransitionView.frame.origin.y = height + self.personalDataTransitionView.frame.height - bottomPaddingSafeArea - bottomPaddingSafeArea
                        print("origin")
                        print(self.personalDataTransitionView.frame.origin.y)
                       },
                       completion: nil)
    }
}

//MARK: - When order history detail case

extension InactiveViewController {

// Show order History detail view
   
   func showOrderHistoryDetailView(for cell: CGRect, and data: OrderHistoryResponseData) {
       
       let rect = CGRect(x: cell.origin.x,
                         y: cell.origin.y,
                         width: PaymentHistoryDetailViewUIData.width.rawValue,
                         height: PaymentHistoryDetailViewUIData.height.rawValue)
       
       self.orderDetailView = OrderHistoryDetailView(frame: rect)
       self.orderDetailView.alpha = 0
    self.orderDetailView.setupView(by: data)
       self.view.addSubview(orderDetailView)
       
       //Animation
       
       UIView.animate(withDuration: 0.5,
                      delay: 0,
                      usingSpringWithDamping: 0.9,
                      initialSpringVelocity: 1,
                      options: .curveEaseOut,
                      animations: {[unowned self] in
                       self.view.layoutIfNeeded()
                       self.orderDetailView.alpha = 1
                       self.orderDetailView.frame = CGRect(x: self.view.bounds.width/2 - PaymentHistoryDetailViewUIData.width.rawValue/2,
                                                         y: self.view.bounds.height/2 - PaymentHistoryDetailViewUIData.height.rawValue/2,
                                                         width: PaymentHistoryDetailViewUIData.width.rawValue,
                                                         height: PaymentHistoryDetailViewUIData.height.rawValue)
                      },
                      completion: nil)
    
    }
    
    func setCellRectAndDetailViewOrderData(rect: CGRect, data: OrderHistoryResponseData) {
        self.vcState = .showOrderHistoryDetailView
        self.rectOfCell = rect
        self.orderHistoryData = data
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

extension InactiveViewController {

    //Show logout view
    private func showLogoutView() {
        
        let rect = CGRect(x: 0,
                          y: UIScreen.main.bounds.height,
                          width: UIScreen.main.bounds.width,
                          height: LogoutViewSizes.height.rawValue)
        
        self.transitionBottomView = TransitionBottomView(frame: rect)
        self.transitionBottomView.setupAs(type: .logout)
        self.transitionBottomView.delegate = self
        self.transitionBottomView.alpha = 0
        self.view.addSubview(self.transitionBottomView)
        
        //Animation
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.transitionBottomView.alpha = 1
                        let window = UIApplication.shared.windows[0]
                        let bottomPadding = window.safeAreaInsets.bottom
                        self.transitionBottomView.frame.origin.y = UIScreen.main.bounds.height - LogoutViewSizes.height.rawValue + bottomPadding
                       },
                       completion: nil)
    }
}

//MARK: - When DeleteAddress Case

extension InactiveViewController {

    //Show deleteAddress view
    private func showDeleteAddressView() {
        
        let rect = CGRect(x: 0,
                          y: UIScreen.main.bounds.height,
                          width: UIScreen.main.bounds.width,
                          height: TransitionBottomViewSizes.deleteAddressHeight.rawValue)
        
        self.transitionBottomView = TransitionBottomView(frame: rect)
        self.transitionBottomView.setupAs(type: .deleteAddress)
        self.transitionBottomView.delegate = self
        self.transitionBottomView.alpha = 0
        self.view.addSubview(self.transitionBottomView)
        
        //Animation
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.transitionBottomView.alpha = 1
                        let window = UIApplication.shared.windows[0]
                        let bottomPadding = window.safeAreaInsets.bottom
                        self.transitionBottomView.frame.origin.y = UIScreen.main.bounds.height - TransitionBottomViewSizes.deleteAddressHeight.rawValue + bottomPadding
                       },
                       completion: nil)
    }
}

//MARK: - When points state

extension InactiveViewController {
    
    private func showPointsView(_ pointsData: PointsResponseData) {
        
        let isNotFirstUse = UserDefaults.standard.getIsNotFirstTimePointsUsage()
        
        let rect = CGRect(x: 0,
                          y: UIScreen.main.bounds.height,
                          width: UIScreen.main.bounds.width,
                          height: isNotFirstUse ? TransitionBottomViewSizes.whenPointsHeght.rawValue :  TransitionBottomViewSizes.firstPointsUseHeight.rawValue)
        
        self.transitionBottomView = TransitionBottomView(frame: rect)
        self.transitionBottomView.alpha = 0
        
        if isNotFirstUse {
            self.transitionBottomView.setupAs(type: .points(pointsData))
        } else {
            self.transitionBottomView.setupAs(type: .pointsFirstTime(pointsData))
        }
        
        self.view.addSubview(transitionBottomView)
        self.transitionBottomView.delegate = self
        
        //Animations
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.transitionBottomView.alpha = 1
                        let window = UIApplication.shared.windows[0]
                        let bottomPadding = window.safeAreaInsets.bottom
                        if isNotFirstUse {
                            self.transitionBottomView.frame.origin.y = UIScreen.main.bounds.height - TransitionBottomViewSizes.whenPointsHeght.rawValue + bottomPadding
                        } else {
                            self.transitionBottomView.frame.origin.y = UIScreen.main.bounds.height - TransitionBottomViewSizes.firstPointsUseHeight.rawValue + bottomPadding
                        }
                       },
                       completion: nil)
        
        
    }
    
    //Calling About Points view
    
    private func showAboutPointsView() {
        
        let rect = CGRect(x: 0,
                          y: UIScreen.main.bounds.height,
                          width: UIScreen.main.bounds.width,
                          height: UIScreen.main.bounds.height - AboutPointsViewSizes.topPadding.rawValue)
        
        self.aboutPointsView = AboutPointsView(frame: rect)
        self.aboutPointsView.delegate = self
        self.aboutPointsView.alpha = 0
        self.view.addSubview(self.aboutPointsView)
        
        //Animation
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.aboutPointsView.alpha = 1
                        self.aboutPointsView.frame.origin.y = AboutPointsViewSizes.topPadding.rawValue
                       },
                       completion: nil)
        
    }
    
    //Hide About Points view
    
    private func hideAboutPointsView(completion: AnimationCompletion?) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.aboutPointsView.alpha = 0
                        self.aboutPointsView.frame.origin.y = UIScreen.main.bounds.height
                       },
                       completion: completion)
    }
}

//MARK: - TransitionBottomViewDelegate

extension InactiveViewController: TransitionBottomViewDelegate  {
    
    //Action on swipe down
    
    func userHasSwipedDown(for viewType: TransitionBottomViewTypes) {
        switch viewType {
            
        case .logout:
            self.hideTransitionBottomView(completion: closeCompletion)
        case .deleteAddress:
            self.hideTransitionBottomView(completion: closeCompletion)
        default:
            break
            
        }
    }
    
    //Action when main button tapped
    
    func mainButtonTapped(for viewType: TransitionBottomViewTypes) {
        
        switch viewType {
        
        case .pointsFirstTime(_), .points(_):
        
            self.hideTransitionBottomView(completion: closeCompletion)
            self.delegate?.beginSavePointsButtonTapped()
        
        case .logout:
            self.hideTransitionBottomView(completion: closeCompletion)
            self.delegate?.logOutButtonTapped()
        case .deleteAddress:
            self.delegate?.deleteButtonTapped()
        default:
            break
        }
        
    }
    
    //Action when main aux button tapped
    func auxButtonTapped(for viewType: TransitionBottomViewTypes) {
        
        switch viewType {
        
        case .logout:
            
            self.hideTransitionBottomView(completion: closeCompletion)
            
        case .deleteAddress:
            
           self.hideTransitionBottomView(completion: closeCompletion)
        
        case .pointsFirstTime(_), .points(_):
            
            let completion: (Bool) -> Void = { [unowned self] _ in
                self.showAboutPointsView()
                self.transitionBottomView.removeFromSuperview()
            }
            
            self.hideTransitionBottomView(completion: completion)
            
        default:
            break
        }
    }
}

extension InactiveViewController: AboutPointsViewDelegate {
    
    func userHasSwipedViewDown() {
        self.closeAboutPointsView()
    }
    
    
    func closeButtonTapped() {
        self.closeAboutPointsView()
    }
    
    func beginSavePointsButtonTapped() {
        self.hideAboutPointsView(completion: closeCompletion)
        self.delegate?.beginSavePointsButtonTapped()
    }
    
    private func closeAboutPointsView() {
        let completion: AnimationCompletion = { [weak self] _ in  self?.dismiss(animated: false)}
        self.hideAboutPointsView(completion: completion)
    }
    
}
