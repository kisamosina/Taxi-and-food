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
    
    //Address Enter View
    private var addressEnterView: AddressEnterView!
    private var addressEnterViewBottomConstraint: NSLayoutConstraint!
    private var addressEnterViewHeightConstraint: NSLayoutConstraint!
    
    //Address Enter Detail View
    private var addressEnterDetailView: AddressEnterDetailView!
    private var addressEnterViewDetailLeadingConstraint: NSLayoutConstraint!
    
    //TipAddress View
    private var tipAddressView: TipAddressView!
    private var tipAddressViewBottomAnchor: NSLayoutConstraint!
    
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
    
    //Bottom indent
    private var bottomPadding: CGFloat {
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.bottom
    }
    
    //Top indent
    private var topPadding: CGFloat {
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.top
    }
}

//MARK:- Work with keyboard

extension MapViewController {
    
    private func addKeyboardWillShowObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillAppear(notification: NSNotification) {
        
        //When addressEnterView is active
        if addressEnterView != nil, let kbHeight = self.getKeyBoardHeight(notification: notification) {
            
            if self.addressEnterViewBottomConstraint.constant == bottomPadding {
                self.addressEnterViewBottomConstraint.constant = -kbHeight
                if tipAddressView != nil {
                    self.tipAddressViewBottomAnchor.constant = -kbHeight
                }
            }
        }

        self.inactiveView.alpha = 1
    }
    
    @objc private func keyboardWillDisappear(notification: NSNotification) {
        
        if addressEnterView != nil {
            self.addressEnterViewBottomConstraint.constant = bottomPadding
            self.inactiveView.alpha = 0
        }
    }
}

//MARK: - MapViewProtocol

extension MapViewController: MapViewProtocol {
    
    func setDestinationAnnotation(for coordinate: CLLocationCoordinate2D?) {
        if let coordinate =  coordinate {
            DispatchQueue.main.async {
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                self.mapView.removeAnnotations(self.mapView.annotations)
                self.mapView.addAnnotation(annotation)
            }
        } else {
            DispatchQueue.main.async {
                self.mapView.removeAnnotations(self.mapView.annotations)
            }
            
        }
    }
    
    func setDestinationAddressText(for addressText: String?) {
        guard let addressText = addressText else { return }
        DispatchQueue.main.async {
            self.addressEnterView.setAddressToTextFieldText(addressText)
        }
        
    }
    
    
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
    
    //Set segues when table view cell in menu view tapped
    
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
        //Annotation for userLocation
        if annotation.isEqual(mapView.userLocation) {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: MapViewControllerStringData.UserLocationReuseId.rawValue)
            annotationView.image = UIImage(named: CustomImagesNames.userPin.rawValue)
            return annotationView
        }
        
        //Annotation for destination
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: MapViewControllerStringData.DestinationLocation.rawValue)
        annotationView.image = UIImage(named: CustomImagesNames.userPinOrange.rawValue)
        return annotationView
    }
}

//MARK: - Address enter view methods

extension MapViewController {
    
    //Setup Address enter view constraints
    private func setupAddressEnterViewConstraints() {
        self.addressEnterView.translatesAutoresizingMaskIntoConstraints = false
        
        addressEnterViewBottomConstraint = self.addressEnterView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: AddressEnterViewSizes.height.rawValue + bottomPadding)
        
        addressEnterViewHeightConstraint = self.addressEnterView.heightAnchor.constraint(equalToConstant: AddressEnterViewSizes.height.rawValue)
        
        NSLayoutConstraint.activate([addressEnterViewHeightConstraint,
                                     addressEnterViewBottomConstraint,
                                     self.addressEnterView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                                     self.addressEnterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                                                    constant: 0)
        ])
    }
    
    //Setup show animation for Address enter view
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
        self.setupAddressEnterViewConstraints()
        
        //Animation
        
        self.addressEnterViewBottomConstraint.constant = bottomPadding
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.addressEnterView.alpha = 1
                       },
                       completion: nil)
    }
    
    //Setup hide animation for Address enter view
    func hideTransitionBottomView(completion: AnimationCompletion? = nil) {
        
        self.addressEnterViewBottomConstraint.constant = AddressEnterViewSizes.height.rawValue + bottomPadding
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.addressEnterView.alpha = 0
                       },
                       completion: completion)
    }
}

//MARK: - AddressEnterViewDelegate

extension MapViewController: AddressEnterViewDelegate {
    
    //Action when addressFromTextFieldHasBecomeActive
    func addressFromTextFieldHasBecomeActive() {
        guard UserDefaults.standard.getTipAddressViewIsShowed()
        else {
            self.callTipAddressView()
            return
        }
        
    }
    
    
    //Action when addressFromPinButtonTapped
    func addressFromPinButtonTapped() {
        self.interactor.sourceAddress = self.addressEnterView.sourceAddress
        self.showAddressEnterDetailView()
    }
    
    
    //Action when table view will disappear
    func tableViewWillDisappear() {
        if addressEnterViewHeightConstraint.constant > AddressEnterViewSizes.height.rawValue {
            self.addressEnterViewHeightConstraint.constant = AddressEnterViewSizes.height.rawValue
        }
    }
    
    //Action when table view will appear
    func tableViewWillAppear() {
        if addressEnterViewHeightConstraint.constant == AddressEnterViewSizes.height.rawValue {
            self.addressEnterViewHeightConstraint.constant += AddressEnterViewSizes.tableViewHeight.rawValue
        }
    }
    
    //Action when map button has tapped
    func mapButtonViewTapped(destinationAddress: String?) {
        guard let showLocationVC = self.getViewController(storyboardId: StoryBoards.AuthAndMap.rawValue, viewControllerId: ViewControllers.ShowLoactionViewController.rawValue) as? ShowLocationViewController else { return }
        let showLocationInteractor = ShowLocationInteractor(view: showLocationVC, userLocation: self.interactor.userLocation, addressEnterDetailViewType: .showDestination(destinationAddress))
        showLocationInteractor.delegate = self.interactor as! MapInteractor
        showLocationVC.interactor = showLocationInteractor
        self.navigationController?.pushViewController(showLocationVC, animated: true)
    }
    
    //Action when user swipe on address enter view
    func userHasSwipedViewDown() {
        self.addressEnterView.endEditing(true)
    }
    
    //Action when Next button tapped
    func nextButtonTapped() {
        self.interactor.sourceAddress = self.addressEnterView.sourceAddress
        self.interactor.destinationAddress = self.addressEnterView.destinationAddress
    }
    
    
}


//MARK: - Address enter detail view methods

extension MapViewController {
    
    //Setup Address enter detail view constraints
    private func setupAddressEnterDetailViewConstraints() {
        
        self.addressEnterDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let addressEnterViewBottomConstraint = self.addressEnterViewBottomConstraint else { return }
        
        let addressEnterViewDetailBottomConstraint = self.addressEnterDetailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: addressEnterViewBottomConstraint.constant)
        let addressEnterViewDetailWidthConstraint = self.addressEnterDetailView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        let addressEnterViewDetailHeightConstraint = self.addressEnterDetailView.heightAnchor.constraint(equalToConstant: AddressEnterDetailViewSizes.height.rawValue)
        self.addressEnterViewDetailLeadingConstraint = self.addressEnterDetailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: UIScreen.main.bounds.width)
        
        NSLayoutConstraint.activate([addressEnterViewDetailBottomConstraint, addressEnterViewDetailWidthConstraint, addressEnterViewDetailHeightConstraint, addressEnterViewDetailLeadingConstraint ])
    }
    
    //Setup AddressEnterDetailView before calling
    
    private func setupAddressEnterDetailView() {
        self.addressEnterDetailView.setupAs(.addressFrom(self.interactor.sourceAddress))
    }
    
    //Setup show animation for Address enter view
    private func showAddressEnterDetailView() {
        
        guard let addressEnterViewBottomConstraint = self.addressEnterViewBottomConstraint else { return }
        
        let rect = CGRect(x: UIScreen.main.bounds.width,
                          y: UIScreen.main.bounds.height - (AddressEnterDetailViewSizes.height.rawValue + addressEnterViewBottomConstraint.constant),
                          width: UIScreen.main.bounds.width,
                          height: AddressEnterDetailViewSizes.height.rawValue)
        
        
                
        self.addressEnterDetailView = AddressEnterDetailView(frame: rect)
                
        self.addressEnterDetailView.alpha = 0
        self.addressEnterDetailView.delegate = self
        self.view.addSubview(self.addressEnterDetailView)
        self.setupAddressEnterDetailView()
        self.setupAddressEnterDetailViewConstraints()
        
        //Animation
        self.addressEnterView.alpha = 0
        self.addressEnterViewDetailLeadingConstraint.constant = 0
                
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.addressEnterDetailView.alpha = 1
                       },
                       completion:  nil )
    }
    
    //Setup hide animation for Address enter view
    private func hideAddressEnterDetailView(completion: AnimationCompletion? = nil) {
        
        self.addressEnterViewDetailLeadingConstraint.constant = UIScreen.main.bounds.width
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[unowned self] in
                        self.view.layoutIfNeeded()
                        self.addressEnterDetailView.alpha = 0
                       },
                       completion:  completion )
    }
    
}

//MARK: - AddressEnterDetailViewDelegate

extension MapViewController: AddressEnterDetailViewDelegate {
    
    func mainButtonTapped(_ addressText: String) {
        
        self.interactor.sourceAddressDetails = addressText
        
        self.hideAddressEnterDetailView {[unowned self] _ in
            self.addressEnterView.alpha = 1
            self.addressEnterDetailView.removeFromSuperview()
            self.addressEnterDetailView = nil
        }
    }
    
}

//MARK: - TipAddres view methods
extension MapViewController {
    
    //Call tip address view
    private func callTipAddressView() {
        
        let rect = CGRect(x: 0,
                          y: 0,
                          width: UIScreen.main.bounds.width,
                          height: UIScreen.main.bounds.height)
        
        
                
        self.tipAddressView = TipAddressView(frame: rect)
        self.view.addSubview(tipAddressView)
        self.tipAddressView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let addressEnterViewBottomConstraint = self.addressEnterViewBottomConstraint else { return }
        
        tipAddressViewBottomAnchor = self.tipAddressView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: addressEnterViewBottomConstraint.constant)
        tipAddressViewBottomAnchor.isActive = true
        self.tipAddressView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tipAddressView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tipAddressView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -topPadding).isActive = true
        
        UserDefaults.standard.storeShowingTipAddressView(true)
    }
}

