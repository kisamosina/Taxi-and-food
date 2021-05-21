//
//  MainViewController.swift
//  Ride and food
//
//  Created by Maxim Alekseev on 11.02.2021.
//

import UIKit
import MapKit


class MapViewController: UIViewController {
    
    //MARK: - Properties
    
    var interactor: MapInteractorProtocol!
    
    //Address Enter View
    private var addressEnterView: AddressEnterView!
    private var addressEnterViewBottomConstraint: NSLayoutConstraint!
    private var addressEnterViewHeightConstraint: NSLayoutConstraint!
    
    //Address Enter Detail View
    private var addressEnterDetailView: AddressEnterDetailView!
    private var addressEnterViewDetailBottomConstraint: NSLayoutConstraint!
    
    //TipAddress View
    private var tipAddressView: TipAddressView!
    private var tipAddressViewBottomAnchor: NSLayoutConstraint!
    
    //Shops List View
    private var shopsListView: ShopsView!
    private var shopsListViewBottomConstraint: NSLayoutConstraint!
    
    //Taxi Order View
    private var taxiOrderView: TaxiOrderView!
    private var taxiOrderViewBottomConstraint: NSLayoutConstraint!
    
    //Top Info view
    private var topInfoView: TopInfoView!
    
    //Waiting Taxi view
    private var waitingTaxiView: WaitingTaxiView!
    private var waitingTaxiViewBottomConstraint: NSLayoutConstraint!

    //Cancelation Order View
    private var cancelationOrderView: CancelationOrderView!
    private var cancelationOrderViewBottomConstraint: NSLayoutConstraint!
    
    //DriversNotFoundView
    private var driversNotFoundView: DriversNotFoundView!
    private var driversNotFoundViewBottomConstraint: NSLayoutConstraint!
    
    //Taxi order status view
    private var taxiOrderStatusView: TaxiOrderStatusView!
    private var taxiOrderStatusViewBottomConstraint: NSLayoutConstraint!
        
    //MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var menuButton: MapRoundButton!
    @IBOutlet weak var lkButton: MapRoundButton!
    @IBOutlet weak var mapCenterButton: MapRoundButton!
    @IBOutlet weak var taxiButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var bottomView: MapBottomView!
    @IBOutlet weak var menuView: MenuView!
    @IBOutlet weak var promoDestinationStackView: UIStackView!
    @IBOutlet weak var promoDestinationView: PromoDestinationView!
    @IBOutlet weak var inactiveView: UIView!
    @IBOutlet weak var leadingLeftSideViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingLeftSideViewConstraint: NSLayoutConstraint!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = MapInteractor(view: self)
        self.initViewSetup()
        self.removeMenuView()
        self.minimizePromoDestinationView()
        self.addSwipes()
        self.addKeyboardWillShowObserver()
        
        DispatchQueue.global(qos: .background).async {
            
            self.interactor.getAllPromos()            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.inactiveView.alpha = 0
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
        self.interactor.setViewControllerState(.enterAddress(.taxi))
    }
    
    @IBAction func foodButtonTapped(_ sender: UIButton) {
        self.interactor.setViewControllerState(.enterAddress(.food))
        self.interactor.getShopList()
    }
    
    @IBAction func closeMenuButtonTapped(_ sender: UIButton) {
        self.inactiveView.alpha = MapInactiveViewAlpha.inactive.rawValue
        self.animateMenuViewMinimizing()
    }
    
    @IBAction func closePromoDescriptionViewTapped(_ sender: Any) {
        self.animatePromoDestinationViewMinimizing()
    }
    //MARK: - Methods
    
    private func initViewSetup() {
        self.inactiveView.alpha = 0
        self.menuView.alpha = 0
        self.promoDestinationView.alpha = 0
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
                self.addressEnterViewBottomConstraint.constant = -kbHeight + 20
                if tipAddressView != nil {
                    self.tipAddressViewBottomAnchor.constant = -kbHeight
                }
            }
            
            if self.addressEnterViewDetailBottomConstraint != nil, self.addressEnterViewDetailBottomConstraint.constant == bottomPadding {
                self.addressEnterViewDetailBottomConstraint.constant = -kbHeight + 20
            }
        }
        
        //When taxi order view is active
        
        if taxiOrderView != nil, let kbHeight = self.getKeyBoardHeight(notification: notification) {
            if self.taxiOrderViewBottomConstraint.constant == bottomPadding {
                self.taxiOrderViewBottomConstraint.constant = -kbHeight + 20
            }
        }
        
        self.inactiveView.alpha = 1
    }
    
    @objc private func keyboardWillDisappear(notification: NSNotification) {
        
        if addressEnterView != nil {
            self.addressEnterViewBottomConstraint.constant = bottomPadding
            self.inactiveView.alpha = 0
        }
        
        if self.addressEnterViewDetailBottomConstraint != nil, self.addressEnterDetailView != nil {
            self.addressEnterViewDetailBottomConstraint.constant = bottomPadding
        }
        
        if taxiOrderView != nil {
            self.taxiOrderViewBottomConstraint.constant = bottomPadding
            self.inactiveView.alpha = 0
        }
    }
}

//MARK: - MapViewProtocol

extension MapViewController: MapViewProtocol {
    
    func activatePromocodeDiscount(_ discount: String) {
        guard let taxiOrderView = taxiOrderView else { return }
        DispatchQueue.main.async {
            taxiOrderView.promocodeButtonView.activateButton(discount)
            taxiOrderView.setNewPrice(self.interactor.finalSumOrder)
        }
    }
    
    func activatePoints(_ pointsText: String) {
        guard let taxiOrderView = taxiOrderView else { return }
        DispatchQueue.main.async {
            taxiOrderView.pointsButtonView.activateButton(pointsText)
            taxiOrderView.setNewPrice(self.interactor.finalSumOrder)
        }
        
    }
    
    func showPoints(_ credit: Int) {
        
        DispatchQueue.main.async {
            let wastePointsInteractor = WastePointsInteractor(credits: credit, orderSum: self.interactor.sumOrder)
            let wastePointsViewController = WastePointsViewController(interactor: wastePointsInteractor)
            wastePointsViewController.modalPresentationStyle = .overFullScreen
            wastePointsViewController.isTapGestureEnabled = true
            wastePointsInteractor.initView(wastePointsViewController)
            wastePointsViewController.delegate = self
            self.present(wastePointsViewController, animated: false)
        }
    }
    
    func draw(route: MKRoute) {
        self.removeOldRoutes()
        DispatchQueue.main.async {
            self.mapView.addOverlay((route.polyline), level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    private func removeOldRoutes() {
        DispatchQueue.main.async {
            self.mapView.removeOverlays(self.mapView.overlays)
        }
    }
    
    func updateShopList(_ list: [ShopResponseData]) {
        guard let shopsView = self.shopsListView else { return }
        shopsView.setShopView(list: list, destinationAddress: self.interactor.destinationAddress, destinationTitle: self.interactor.destinationAddressTitle)
    }
    
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
        self.interactor.buildARoute()
        guard let addressText = addressText else { return }
        DispatchQueue.main.async {
            if let addressEnterView = self.addressEnterView {
                addressEnterView.setAddressToTextFieldText(addressText)
            }
            
            if let taxiOrderView = self.taxiOrderView {
                taxiOrderView.setDestinationAddress(destinationAddress: addressText)
            }
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
    
    private func dismissAddressEnterView() {
        guard let addressEnterView = self.addressEnterView else {return}
        
        let completion: AnimationCompletion = { [weak self] _ in
            self?.bottomView.isHidden = false
            addressEnterView.removeFromSuperview()
            self?.addressEnterView = nil
        }
        
        self.hideAddressEnterView(completion: completion)
    }
    
    private func dismissShopsView() {
        guard let shopsListView = self.shopsListView else { return }
        
        let completion: AnimationCompletion = { [weak self] _ in
            self?.bottomView.isHidden = false
            shopsListView.removeFromSuperview()
            self?.shopsListView = nil
        }
        
        self.hideShopsView(completion: completion)
    }
    
    private func dismissTaxiViews() {
        if let addressEnterDetailView = self.addressEnterDetailView {
            self.hideAddressEnterDetailView {[weak self] _ in
                guard let self = self else { return }
                self.bottomView.isHidden = false
                addressEnterDetailView.removeFromSuperview()
                self.addressEnterDetailView = nil
                self.addressEnterViewDetailBottomConstraint = nil
            }
        }
        
        if let taxiOrderView = self.taxiOrderView {
            self.hideTaxiOrderView { [weak self] _ in
                guard let self = self else { return }
                self.bottomView.isHidden = false
                taxiOrderView.removeFromSuperview()
                self.topInfoView.removeFromSuperview()
                self.topInfoView = nil
                self.taxiOrderView = nil
                self.taxiOrderViewBottomConstraint = nil
            }
        }
    }
    
    func setViews(for state: MapViewControllerStates) {
        
        switch state {
        
        case .start:
            self.menuButton.setImage(UIImage(named: CustomImagesNames.menuButton.rawValue), for: .normal)
            self.lkButton.isHidden = false
            self.mapCenterButton.isHidden = false
            self.dismissAddressEnterView()
            self.dismissShopsView()
            self.dismissTaxiViews()
            self.removeOldRoutes()
            
        case .enterAddress(let addresEnterViewType):
            self.menuButton.setImage(UIImage(named: CustomImagesNames.backButton.rawValue), for: .normal)
            self.lkButton.isHidden = true
            self.bottomView.isHidden = true
            self.mapCenterButton.isHidden = true
            self.showAddressEnterView(as: addresEnterViewType)
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
    
    func updateData() {
        
        DispatchQueue.main.async {
            
            guard let promos = self.interactor.promos else {return}
            
            for promo in promos {
                
                if self.interactor.isPromoAvailableByTime(timeFrom: promo.timeFrom ?? "", timeTo: promo.timeTo ?? "") == true {
                    self.promoDestinationView.alpha = 1
                    if promo.media.count > 2 {
                        self.promoDestinationView.imageView.webImage(promo.media[1].url ?? "")
                    }
                    self.promoDestinationView.nameLabel.text = promo.title
                    
                }
                
            }
            
        }
        
    }
    
    func showFoodCategoriesForShop(_ shopDetailData: FoodCategoriesResponseData?) {
        guard let shopDetailData = shopDetailData else { return }
        
        
        DispatchQueue.main.async {
            
            let chooseFoodViewController = ChooseFoodCategoryViewController()
            
            chooseFoodViewController.delegate = self
            
            chooseFoodViewController.modalPresentationStyle = .overCurrentContext
                        
            let chooseFoodInteractor = ChooseFoodInteractor(view: chooseFoodViewController, foodCategories: shopDetailData)
            
            chooseFoodViewController.setInteractor(interactor: chooseFoodInteractor)
        
            self.present(chooseFoodViewController, animated: false, completion: nil)
        }
    }
}

//MARK: - Menu View Methods

extension MapViewController {
    
    private func animateMenuViewMaximizing() {
        self.menuView.reloadView(with: interactor.mapMenuData)
        Animator.shared.showView(animationType: .menuViewAnimation(self.menuView, self.leadingLeftSideViewConstraint, self.trailingLeftSideViewConstraint), from: self.view)
    }
    
    private func animateMenuViewMinimizing() {
        
        Animator.shared.hideView(animationType: .menuViewAnimation(self.menuView, self.leadingLeftSideViewConstraint, self.trailingLeftSideViewConstraint), from: self.view)
        
    }
    
    //Remove left menu
    private func removeMenuView() {
        self.leadingLeftSideViewConstraint.constant = -UIScreen.main.bounds.width
        self.trailingLeftSideViewConstraint.constant = UIScreen.main.bounds.width
        self.inactiveView.alpha = 0
    }
}

//MARK: - MenuViewDelegate

extension MapViewController: MenuViewDelegate {
    
    //Set segues when table view cell in menu view tapped
    
    func performSegue(_ type: MapViewControllerSegue) {
        
        self.removeMenuView()
        
        switch type {
        
        case .Tariffs:
            
            self.interactor.getTariffs()
            
        case .Settings:
            let vc = self.getViewController(storyboardId: StoryBoards.Settings.rawValue, viewControllerId: ViewControllers.SettingsViewController.rawValue)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .Promocode:
            let vc = self.getViewController(storyboardId: StoryBoards.Promocode.rawValue, viewControllerId: ViewControllers.PromocodeViewController.rawValue)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .PaymentWay:
            self.interactor.getPaymentData()
            
        case .Service:
            let vc = self.getViewController(storyboardId: StoryBoards.Service.rawValue, viewControllerId: ViewControllers.ServiceViewController.rawValue)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .Promo:
            let vc = self.getViewController(storyboardId: StoryBoards.Promo.rawValue, viewControllerId: ViewControllers.PromoViewController.rawValue)
            self.navigationController?.pushViewController(vc, animated: true)
            
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return interactor.makePolylineRended(from: overlay)
    }
}

//MARK: - Address enter view methods

extension MapViewController {
    
    //Setup Address enter view constraints
    private func setupAddressEnterViewConstraints(viewType: AddressEnterViewType) {
        
        self.addressEnterView.translatesAutoresizingMaskIntoConstraints = false
        
        addressEnterViewBottomConstraint = self.addressEnterView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: viewType.viewHeight() + bottomPadding)
        
        addressEnterViewHeightConstraint = self.addressEnterView.heightAnchor.constraint(equalToConstant: viewType.viewHeight())
        
        NSLayoutConstraint.activate([addressEnterViewHeightConstraint,
                                     addressEnterViewBottomConstraint,
                                     self.addressEnterView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
                                     self.addressEnterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                                                    constant: 0)
        ])
    }
    
    //Setup show animation for Address enter view
    private func showAddressEnterView(as type: AddressEnterViewType) {
        
        self.addressEnterView = AddressEnterView(frame: CGRect.makeRect(height: type.viewHeight()))
        self.addressEnterView.alpha = 0
        self.addressEnterView.delegate = self
        self.addressEnterView.mapButtonDelegate = self
        self.addressEnterView.setAddresses(self.interactor.addresses)
        self.view.addSubview(self.addressEnterView)
        self.addressEnterView.setView(as: type)
        self.addressEnterView.setAddressFromTextFieldText(interactor.addressString)
        self.setupAddressEnterViewConstraints(viewType: type)
        
        //Animation
        Animator.shared.showView(animationType: .usualBottomAnimation(self.addressEnterView, self.addressEnterViewBottomConstraint), from: self.view)
    }
    
    //Setup hide animation for Address enter view
    func hideAddressEnterView(completion: AnimationCompletion? = nil) {
        
        self.addressEnterViewBottomConstraint.constant = self.addressEnterView.type.viewHeight() + bottomPadding
        
        Animator.shared.hideView(animationType: .usualBottomAnimation(self.addressEnterView, self.addressEnterViewBottomConstraint), from: self.view, viewHeight: self.addressEnterView.type.viewHeight() + bottomPadding, completion: completion)
    }
}

//MARK: - AddressEnterViewDelegate

extension MapViewController: AddressEnterViewDelegate {
    
    func setDestinationTitle(_ title: String) {
        self.interactor.destinationAddressTitle = title
    }
    
    func removeDestinationTitle() {
        self.interactor.destinationAddressTitle = nil
    }
    
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
        if addressEnterViewHeightConstraint.constant > self.addressEnterView.type.viewHeight()  {
            self.addressEnterViewHeightConstraint.constant = self.addressEnterView.type.viewHeight()
        }
    }
    
    //Action when table view will appear
    func tableViewWillAppear() {
        if addressEnterViewHeightConstraint.constant == self.addressEnterView.type.viewHeight()  {
            self.addressEnterViewHeightConstraint.constant += AddressEnterViewSizes.tableViewHeight.rawValue
        }
    }
        
    //Action when user swipe on address enter view
    func userHasSwipedViewDown() {
        self.interactor.setViewControllerState(.start)
    }
    
    //Action when Next button tapped
    func nextButtonTapped() {
        self.interactor.destinationAddress = self.addressEnterView.destinationAddress
        guard let type = self.addressEnterView.type else { return }
        switch type {
        case .taxi:
            self.interactor.sourceAddress = self.addressEnterView.sourceAddress
            self.hideAddressEnterView {[weak self] _ in
                guard let self = self else { return }
                self.showTaxiOrdreView()
            }
        case .food:
            self.hideAddressEnterView {[weak self] _ in
                guard let self = self else { return }
                self.showShopsView()
                self.shopsListView.setShopView(list: self.interactor.shopsList, destinationAddress: self.interactor.destinationAddress, destinationTitle: self.interactor.destinationAddressTitle)
                self.addressEnterView = nil
            }
        }
    }
}

//MARK: - MapButtonDelegate

extension MapViewController: MapButtonDelegate {
    
    func mapButtonTapped(destinationAddress: String?) {
        guard let showLocationVC = self.getViewController(storyboardId: StoryBoards.AuthAndMap.rawValue, viewControllerId: ViewControllers.ShowLoactionViewController.rawValue) as? ShowLocationViewController else { return }
        let showLocationInteractor = ShowLocationInteractor(view: showLocationVC, userLocation: self.interactor.userLocation, addressEnterDetailViewType: .showDestination(destinationAddress))
        showLocationInteractor.delegate = self.interactor as! MapInteractor
        showLocationVC.interactor = showLocationInteractor
        self.navigationController?.pushViewController(showLocationVC, animated: true)
    }
}

//MARK: - Address enter detail view methods

extension MapViewController {
    
    //Setup AddressEnterDetailView before calling
    private func setupAddressEnterDetailView() {
        self.addressEnterDetailView.setupAs(.addressFrom(self.interactor.sourceAddress))
    }
    
    //Setup show animation for Address enter view
    private func showAddressEnterDetailView() {
        
        guard let addressEnterViewBottomConstraint = self.addressEnterViewBottomConstraint else { return }
        
        self.addressEnterDetailView = AddressEnterDetailView(frame: CGRect.makeRect(height: AddressEnterDetailViewSizes.height.rawValue))
        self.addressEnterDetailView.delegate = self
        self.view.addSubview(self.addressEnterDetailView)
        self.setupAddressEnterDetailView()
        self.addressEnterDetailView.setupConstraints(for: self.view,
                                                     viewHeight: AddressEnterDetailViewSizes.height.rawValue,
                                                     bottomContraintConstant: AddressEnterDetailViewSizes.height.rawValue + bottomPadding) { [weak self] constraint in
            guard let self = self else { return }
            self.addressEnterViewDetailBottomConstraint = constraint
        }
        
        self.addressEnterView.alpha = 0
        
        Animator.shared.showView(animationType: .usualBottomAnimation(self.addressEnterDetailView, self.addressEnterViewDetailBottomConstraint),
                                 from: self.view,
                                 for: addressEnterViewBottomConstraint.constant)
    }
    
    //Setup hide animation for Address enter view
    private func hideAddressEnterDetailView(completion: AnimationCompletion? = nil) {
        
        Animator.shared.hideView(animationType: .usualBottomAnimation(self.addressEnterDetailView, self.addressEnterViewDetailBottomConstraint),
                                 from: self.view,
                                 viewHeight: AddressEnterDetailViewSizes.height.rawValue,
                                 completion: completion )
    }
    
}

//MARK: - AddressEnterDetailViewDelegate

extension MapViewController: AddressEnterDetailViewDelegate {
    
    func mainButtonTapped(_ addressText: String) {
        
        self.interactor.sourceAddressDetails = addressText
        
        self.hideAddressEnterDetailView {[unowned self] _ in
            
            if let addressEnterView = self.addressEnterView {
                    addressEnterView.alpha = 1
            }
            self.addressEnterDetailView.removeFromSuperview()
            self.addressEnterDetailView = nil
        }
    }
}

//MARK: - TaxiOrderView

extension MapViewController {
    
    //Setup show animation for taxi order view
    private func showTaxiOrdreView() {
        
        self.taxiOrderView = TaxiOrderView(frame: CGRect.makeRect(height: TaxiOrderViewSizesData.viewHeight.rawValue))
        self.view.addSubview(self.taxiOrderView)
        self.taxiOrderView.setupConstraints(for: self.view,
                                            viewHeight: TaxiOrderViewSizesData.viewHeight.rawValue,
                                            bottomContraintConstant: TaxiOrderViewSizesData.viewHeight.rawValue + bottomPadding) { [weak self] constraint in
            guard let self = self else { return }
            self.taxiOrderViewBottomConstraint = constraint
        }
        self.taxiOrderView.delegate = self
        self.taxiOrderView.mapButtonDelegate = self
        self.taxiOrderView.setupAdresses(from: self.interactor.sourceAddress ?? "", to: self.interactor.destinationAddress ?? "")
        Animator.shared.showView(animationType: .usualBottomAnimation(self.taxiOrderView, self.taxiOrderViewBottomConstraint),
                                 from: self.view) {[weak self] _ in
            guard let self =  self else { return }
            self.showTopInfoView()
        }
    }
    
    //Setup hide animation for Taxi order view
    private func hideTaxiOrderView(completion: AnimationCompletion? = nil) {
        
        Animator.shared.hideView(animationType: .usualBottomAnimation(self.taxiOrderView, self.taxiOrderViewBottomConstraint),
                                 from: self.view,
                                 viewHeight: AddressEnterDetailViewSizes.height.rawValue,
                                 completion: completion )
    }
    
}

//MARK: - TaxiOrderView Delegate

extension MapViewController: TaxiOrderViewDelegate {
    func orderButtonTapped() {
        hideTaxiOrderView { [weak self] _ in
            guard let self = self else { return }
            self.showWaitingTaxiView()
            self.menuButton.isHidden = true
            self.topInfoView.isHidden = true
        }
    }
    
   
    func tariffSelected(tariffPrice: Double) {
        interactor.setSumOrder(tariffPrice)
        interactor.promocodeDiscount = 0
        interactor.enteredPoints = nil
        taxiOrderView.promocodeButtonView.returnToInitialView()
        taxiOrderView.pointsButtonView.returnToInitialView()
    }
    
    func promocodeButtonTapped() {
        let promocodeActivatingInteractor = PromocodeActivatingInteractor()
        let promocodeActivatingViewController = PromocodeActivatingViewController(interactor: promocodeActivatingInteractor)
        promocodeActivatingInteractor.initView(promocodeActivatingViewController)
        promocodeActivatingViewController.modalPresentationStyle = .overFullScreen
        promocodeActivatingViewController.isTapGestureEnabled = true
        promocodeActivatingViewController.delegate = self
        present(promocodeActivatingViewController, animated: false, completion: nil)
    }
    
    func pointsButtonTapped() {
        interactor.getPoints()
    }
    
    
    func viewHasSwipedDown() {
        self.interactor.setViewControllerState(.start)
    }
    
    
}

//MARK: - TipAddres view methods

extension MapViewController {
    
    //Call tip address view
    private func callTipAddressView() {
        
        self.tipAddressView = TipAddressView(frame: CGRect.makeRectWidthAndHeightScreen())
        self.view.addSubview(tipAddressView)
        
        guard let addressEnterViewBottomConstraint = self.addressEnterViewBottomConstraint else { return }
        
        self.tipAddressView.setupConstraints(for: self.view, bottomConstraintConstant: addressEnterViewBottomConstraint.constant) {[weak self] constraint in
            guard let self = self else { return }
            self.tipAddressViewBottomAnchor = constraint
        }
        
        UserDefaults.standard.storeShowingTipAddressView(true)
    }
}

// MARK: - Shops view methods

extension MapViewController {
    
    func showShopsView() {
        
        self.shopsListView = ShopsView(frame: CGRect.makeRect(height: ShopsViewUIData.viewHeight.rawValue))
        self.shopsListView.delegate = self
        self.view.addSubview(shopsListView)
        
        self.shopsListView.setupConstraints(for: self.view,
                                            viewHeight: ShopsViewUIData.viewHeight.rawValue,
                                            bottomContraintConstant: ShopsViewUIData.viewHeight.rawValue + bottomPadding,
                                            with: {[weak self] bottomConstraint in
                                                guard let self = self else { return }
                                                self.shopsListViewBottomConstraint = bottomConstraint})
        
        Animator.shared.showView(animationType: .usualBottomAnimation(self.shopsListView, shopsListViewBottomConstraint), from: self.view)
    }
    
    func hideShopsView(completion: AnimationCompletion? = nil) {
        Animator.shared.hideView(animationType: .usualBottomAnimation(self.shopsListView, shopsListViewBottomConstraint),
                                 from: self.view,
                                 viewHeight: ShopsViewUIData.viewHeight.rawValue, completion: completion)
    }
}

// MARK: - ShopsViewDelegate

extension MapViewController: ShopsViewDelegate {
    
    func goToShop(_ shopId: Int) {
        self.interactor.makeRequest(for: shopId)
    }
    
    func userHasSwipedDownView() {
        self.interactor.setViewControllerState(.start)
    }
}

// MARK: - Work with Promos

extension MapViewController {
    
    
    private func initPromoDestinationViewSetUp() {
        self.inactiveView.alpha = 0
        self.promoDestinationView.alpha = 0
    }
    
    private func minimizePromoDestinationView() {
//        self.topPromoDestinationViewConstraint.constant = -UIScreen.main.bounds.height
        promoDestinationStackView.isHidden = true
        
    }
    
    private func maximizePromoDestinationView() {
//        self.topPromoDestinationViewConstraint.constant = MapViewControllerConstraintsData.maximizedTopPromoDestinationViewConstant.rawValue
        promoDestinationStackView.isHidden = false
    }
    
    private func animatePromoDestinationViewMaximizing() {
        self.maximizePromoDestinationView()
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[weak self] in
                        self?.view.layoutIfNeeded()
                        self?.promoDestinationView.alpha = 1
                       },
                       completion: nil)
        
    }
    
    private func animatePromoDestinationViewMinimizing() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {[weak self] in
                        self?.view.layoutIfNeeded()
                        self?.promoDestinationView.alpha = 0
                       },
                       completion: nil)
    }
}

// MARK: - Choose food view controller delegate

extension MapViewController: ChooseFoodCategoryViewControllerDelegate {
    
    func userHasSwiped() {
        self.interactor.setViewControllerState(.start)
    }
    
}

// MARK: - Top info view

extension MapViewController {
    
    private func showTopInfoView() {
        let rect = CGRect(x: 0, y: 0, width: 125, height: TopInfoViewSizesData.viewHeight.rawValue)
        self.topInfoView = TopInfoView(frame: rect)
        self.view.addSubview(topInfoView)
        self.topInfoView.setupTitle(self.interactor.estimatedTripTime)
        self.topInfoView.setupConstraintXCenterAnd(topConstant: topPadding + TopInfoViewSizesData.topConstraint.rawValue, height: TopInfoViewSizesData.viewHeight.rawValue)
    }
}

//MARK: - PromocodeActivatingViewControllerDelegate

extension MapViewController: PromocodeActivatingViewControllerDelegate {
    
    func promocodeHasActivated(discount: Int) {
        interactor.setPromocodeDiscount(discount: discount)
    }
}

//MARK: - WastePointsViewControllerDelegate

extension MapViewController: WastePointsViewControllerDelegate {
    
    func waste(points: Int) {
        interactor.saveWastedPoints(points)
    }
}

//MARK: - Waiting Taxi View

extension MapViewController {
    
    //Setup show animation for taxi order view
    private func showWaitingTaxiView() {
        
        waitingTaxiView = WaitingTaxiView(frame: CGRect.makeRect(height: WaitingTaxiViewSizes.viewSize))
        waitingTaxiView.delegate = self
        view.addSubview(waitingTaxiView)
        self.waitingTaxiView.setupConstraints(for: view,
                                              viewHeight: WaitingTaxiViewSizes.viewSize,
                                              bottomContraintConstant: WaitingTaxiViewSizes.viewSize + bottomPadding) { [weak self] constraint in
            guard let self = self else { return }
            self.waitingTaxiViewBottomConstraint = constraint
        }
        Animator.shared.showView(animationType: .usualBottomAnimation(waitingTaxiView, waitingTaxiViewBottomConstraint),from: view)
    }
    
    //Setup hide animation for Waiting Taxi view
    private func hideWaitingTaxiView(completion: AnimationCompletion? = nil) {
        Animator.shared.hideView(animationType: .usualBottomAnimation(waitingTaxiView, waitingTaxiViewBottomConstraint), from: view, viewHeight: WaitingTaxiViewSizes.viewSize, completion: completion)
    }
}

//MARK: - WaitingTaxiViewDelegate

extension MapViewController: WaitingTaxiViewDelegate {
    
    func cancelButtonTapped() {
        hideWaitingTaxiView { [weak self] _ in
            guard let self = self else { return }
            self.waitingTaxiView.removeFromSuperview()
            self.waitingTaxiView = nil
            self.waitingTaxiViewBottomConstraint = nil
//            self.showCancelationOrderView()
//            self.showDriversNotFoundView()
            self.showTaxiOrderStatusView()
        }
//        guard let sentVC = getViewController(storyboardId: StoryBoards.Service.rawValue, viewControllerId: ViewControllers.SentViewController.rawValue) as? SentViewController else { return }
//        sentVC.configAs(.continueTaxiSearch)
//        navigationController?.pushViewController(sentVC, animated: true)
        
//        let taxiHasFoundInteractor = TaxiFoundInteractor()
//        let taxiHasFoundVC = TaxiFoundViewController(interactor: taxiHasFoundInteractor)
//        taxiHasFoundInteractor.initView(taxiHasFoundVC)
//        taxiHasFoundVC.modalPresentationStyle = .overFullScreen
//        present(taxiHasFoundVC, animated: false)
    }
    
}

//MARK: - Cancelation Order View

extension MapViewController {
    
    private func showCancelationOrderView() {
        cancelationOrderView = CancelationOrderView(frame: CGRect.makeRect(height: CancelationOrderViewSizes.viewHeight))
        view.addSubview(cancelationOrderView)
        cancelationOrderView.setupConstraints(for: view,
                                              viewHeight: CancelationOrderViewSizes.viewHeight,
                                              bottomContraintConstant: CancelationOrderViewSizes.viewHeight + bottomPadding) {[weak self] constraint in
            guard let self = self else { return }
            self.cancelationOrderViewBottomConstraint = constraint
        }
        Animator.shared.showView(animationType: .usualBottomAnimation(cancelationOrderView, cancelationOrderViewBottomConstraint), from: view)
    }
}

//MARK: - DriversNotFoundView

extension MapViewController {
    
    func showDriversNotFoundView() {
        driversNotFoundView = DriversNotFoundView(frame: CGRect.makeRect(height: DriversNotFoundViewSizes.viewHeight))
        view.addSubview(driversNotFoundView)
        driversNotFoundView.setupConstraints(for: view, viewHeight: DriversNotFoundViewSizes.viewHeight + bottomPadding, bottomContraintConstant: DriversNotFoundViewSizes.viewHeight) {[weak self] constraint in
            guard let self = self else  { return }
            self.driversNotFoundViewBottomConstraint = constraint
        }
        Animator.shared.showView(animationType: .usualBottomAnimation(driversNotFoundView, driversNotFoundViewBottomConstraint), from: view)
    }
    
}

//MARK: - TaxiOrderStatusView

extension MapViewController {
    
    func showTaxiOrderStatusView() {
        taxiOrderStatusView = TaxiOrderStatusView(frame: CGRect.makeRect(height: TaxiOrderStatusViewSizes.viewHeight))
        view.addSubview(taxiOrderStatusView)
        taxiOrderStatusView.setupConstraints(for: view, viewHeight: TaxiOrderStatusViewSizes.viewHeight, bottomContraintConstant: TaxiOrderStatusViewSizes.viewHeight + bottomPadding) {[weak self] constraint in
            guard let self = self else { return }
            self.taxiOrderStatusViewBottomConstraint = constraint
        }
        Animator.shared.showView(animationType: .usualBottomAnimation(taxiOrderStatusView, taxiOrderStatusViewBottomConstraint), from: view)
    }
}
