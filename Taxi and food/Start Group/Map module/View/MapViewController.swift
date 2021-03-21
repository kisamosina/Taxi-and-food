//
//  MainViewController.swift
//  Ride and food
//
//  Created by Maxim Alekseev on 11.02.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    typealias AnimationCompletion = (Bool) -> Void
    
    //MARK: - Properties
    
    var interactor: MapInteractorProtocol!
    var addressEnterView: AddressEnterView!
    
    //MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var menuButton: MapRoundButton!
    @IBOutlet weak var lkButton: MapRoundButton!
    @IBOutlet weak var mapCenterButton: MapRoundButton!
    @IBOutlet weak var taxiButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var bottomView: MapBottomView!
    @IBOutlet weak var menuView: MenuView!
    @IBOutlet weak var inactiveView: UIView!
    @IBOutlet weak var leadingLeftSideViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingLeftSideViewConstraint: NSLayoutConstraint!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = MapInteractor(view: self)
        self.initViewSetup()
        self.minimizeMenuView()
        self.addSwipes()
        self.addKeyboardWillShowObserver()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: - IBActions
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
        switch interactor.mapViewControllerState {
        
        case .start:
            self.inactiveView.alpha = MapInactiveViewAlpha.active.rawValue
            self.animateMenuViewMaximizing()
        case .enterAddress:
            self.interactor.setViewControllerState(.start)
        }
    }
    
    
    @IBAction func lkButtonTapped(_ sender: UIButton) {
        let vc = self.getViewController(storyboardId: StoryBoards.PersonalAccount.rawValue, viewControllerId: ViewControllers.PersonalAccountViewController.rawValue)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func mapCenterButtonTapped(_ sender: UIButton) {
        guard let region = self.interactor.getUserLoctaionRegion() else { return }
        self.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func taxiButtonTapped(_ sender: UIButton) {
        self.interactor.setViewControllerState(.enterAddress)
    }
    
    @IBAction func foodButtonTapped(_ sender: UIButton) {
        
    }
    
    
    @IBAction func closeMenuButtonTapped(_ sender: UIButton) {
        self.inactiveView.alpha = MapInactiveViewAlpha.inactive.rawValue
        self.animateMenuViewMinimizing()
        
    }
    
    //MARK: - Methods
    
    private func initViewSetup() {
        self.inactiveView.alpha = 0
        self.menuView.alpha = 0
        self.menuView.setupView(with: interactor.mapMenuData)
        self.menuView.delegate = self
        self.mapView.showsUserLocation = true
    }
    
    //Add Swipes
    
    func addSwipes() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            self.inactiveView.alpha = MapInactiveViewAlpha.inactive.rawValue
            self.animateMenuViewMinimizing()
            
        default:
            break
        }
    }
    
}

//MARK: - Sizes

extension MapViewController {
    
    var bottomPadding: CGFloat {
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.bottom
    }
    
}

//MARK:- Work with keyboard

extension MapViewController {
    
    private func addKeyboardWillShowObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillAppear(notification: NSNotification) {
        if let kbHeight = self.getKeyBoardHeight(notification: notification),
           let addressEnterView = self.addressEnterView,
           addressEnterView.frame.origin.y == UIScreen.main.bounds.height - AddressEnterViewSizes.height.rawValue + bottomPadding {
            addressEnterView.frame.origin.y -= kbHeight
            self.inactiveView.alpha = 1
        }
    }
    
    @objc private func keyboardWillDisappear(notification: NSNotification) {
        if let kbHeight = self.getKeyBoardHeight(notification: notification), let addressEnterView = self.addressEnterView {
            addressEnterView.frame.origin.y += kbHeight
            self.inactiveView.alpha = 0
        }
    }
}

//MARK: - MapViewProtocol

extension MapViewController: MapViewProtocol {
    
    func showPaymentsViewController(data: [PaymentCardResponseData]) {
        
        DispatchQueue.main.async {
            guard let paymentVC = self.getViewController(storyboardId: StoryBoards.PaymentWay.rawValue, viewControllerId: ViewControllers.PaymentWayViewController.rawValue) as? PaymentWayViewController else { return }
            paymentVC.initPaymentWayInteractor(with: data)
            self.removeMenuView()
            self.navigationController?.pushViewController(paymentVC, animated: true)
        }
    }
    
    
    func setBottomViewAddressLabel(text: String?) {
        self.bottomView.setAddressLabelText(text)
    }
    
    
    func setViews(for state: MapViewControllerStates) {
        
        switch state {
        
        case .start:
            self.menuButton.setImage(UIImage(named: CustomImagesNames.menuButton.rawValue), for: .normal)
            self.lkButton.isHidden = false
            self.mapCenterButton.isHidden = false
            if let addressEnterView = self.addressEnterView {
                let completion: AnimationCompletion = { [weak self] _ in
                    self?.bottomView.isHidden = false
                    addressEnterView.removeFromSuperview()
                    self?.addressEnterView = nil
                }
                self.hideTransitionBottomView(completion: completion)
            }
            
        case .enterAddress:
            self.menuButton.setImage(UIImage(named: CustomImagesNames.backButton.rawValue), for: .normal)
            self.lkButton.isHidden = true
            self.bottomView.isHidden = true
            self.mapCenterButton.isHidden = true
            self.showAddressEnterView()
        }
    }
    
    
    func showUserLocation(region: MKCoordinateRegion) {
        self.mapView.setRegion(region, animated: true)
    }
    
    
    func showLocationSettingsAlert(title: String, message: String) {
        
        let ac = UIAlertController.showLocationSettingsAlert(title: title, message: message)
        
        DispatchQueue.main.async {
            self.present(ac, animated: true)
        }
        
    }
    
    
    func showTariffPageViewController(_ tariffs: [TariffData]) {
        let storyboard = UIStoryboard(name: StoryBoards.Tarifs.rawValue, bundle: nil)
        DispatchQueue.main.async {
            let tariffPageVC = storyboard.instantiateInitialViewController() as! TariffsPageViewController
            tariffPageVC.interactor = TariffPageInteractor(view: tariffPageVC, tariffs: tariffs)
            self.removeMenuView()
            self.navigationController?.pushViewController(tariffPageVC, animated: true)
        }
        
    }
}

//MARK: - Menu View Methods

extension MapViewController {
    
    private func minimizeMenuView() {
        self.leadingLeftSideViewConstraint.constant = -UIScreen.main.bounds.width
        self.trailingLeftSideViewConstraint.constant = UIScreen.main.bounds.width
    }
    
    private func maximizeMenuView() {
        self.leadingLeftSideViewConstraint.constant = 0
        self.trailingLeftSideViewConstraint.constant = MapViewControllerConstraintsData.maximizedTrailingMenuViewConstant.rawValue
    }
    
    private func animateMenuViewMaximizing() {
        self.maximizeMenuView()
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[weak self] in
                        self?.view.layoutIfNeeded()
                        self?.menuView.alpha = 1
                       },
                       completion: nil)
    }
    
    private func animateMenuViewMinimizing() {
        self.minimizeMenuView()
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[weak self] in
                        self?.view.layoutIfNeeded()
                        self?.menuView.alpha = 0
                       },
                       completion: nil)
    }
    
    //Remove left menu
    private func removeMenuView() {
        self.minimizeMenuView()
        self.inactiveView.alpha = MapInactiveViewAlpha.inactive.rawValue
    }
}

//MARK: - MenuViewDelegate

extension MapViewController: MenuViewDelegate {
    
    func performSegue(_ type: MapViewControllerSegue) {
        switch type {
        
        case .Tariffs:
            self.interactor.getTariffs()
            
        case .Promocode:
            let storyboard = UIStoryboard(name: StoryBoards.Promocode.rawValue, bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: ViewControllers.PromocodeViewController.rawValue)
            self.removeMenuView()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .PaymentWay:
            self.interactor.getPaymentData()
        case .unknown:
            break
            
        }
    }
}

//MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(mapView.userLocation) {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: MapViewControllerStringData.UserLocationReuseId.rawValue)
            annotationView.image = UIImage(named: CustomImagesNames.userPin.rawValue)
            return annotationView
        }
        return nil
    }
}

//MARK: - Taxi view methods

extension MapViewController {
    
    private func showAddressEnterView() {
        let rect = CGRect(x: 0,
                          y: UIScreen.main.bounds.height,
                          width: UIScreen.main.bounds.width,
                          height: AddressEnterViewSizes.height.rawValue)
        
        self.addressEnterView = AddressEnterView(frame: rect)
        self.addressEnterView.alpha = 0
        self.addressEnterView.delegate = self
        self.addressEnterView.setAddresses(self.interactor.addresses)
        self.view.addSubview(self.addressEnterView)
        self.addressEnterView.setAddressFromTextFieldText(interactor.addressString)
        
        //Animation
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.addressEnterView.alpha = 1
                        self.addressEnterView.frame.origin.y = UIScreen.main.bounds.height - AddressEnterViewSizes.height.rawValue + self.bottomPadding
                       },
                       completion: nil)
    }
    
    func hideTransitionBottomView(completion: AnimationCompletion? = nil) {
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.addressEnterView.alpha = 0
                        self.addressEnterView.frame.origin.y = UIScreen.main.bounds.height
                       },
                       completion: completion)
        
    }
}

//MARK: - AddressEnterViewDelegate

extension MapViewController: AddressEnterViewDelegate {
    
    func tableViewWillAppear() {
        if addressEnterView.frame.height == AddressEnterViewSizes.height.rawValue {
            let addressEnterViewHeight = addressEnterView.frame.height + AddressEnterViewSizes.tableViewHeight.rawValue
            let addressEnterViewY = addressEnterView.frame.origin.y - AddressEnterViewSizes.tableViewHeight.rawValue - bottomPadding
            
            let rect = CGRect(x: 0, y: addressEnterViewY, width: UIScreen.main.bounds.width, height: addressEnterViewHeight)
            self.addressEnterView.frame = rect
        }
    }
    
    
    func mapButtonViewTapped() {
        guard let showLocationVC = self.getViewController(storyboardId: StoryBoards.AuthAndMap.rawValue, viewControllerId: ViewControllers.ShowLoactionViewController.rawValue) as? ShowLoactionViewController else { return }
        let region = self.interactor.getUserLoctaionRegion()
        showLocationVC.setMapRegion(region)
        self.present(showLocationVC, animated: true, completion: nil)
    }
    
    
    func userHasSwipedViewDown() {
        self.interactor.setViewControllerState(.start)
    }
    
    func nextButtonTapped() {
        
    }
    
}
