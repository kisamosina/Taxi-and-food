//
//  MainViewController.swift
//  Ride and food
//
//  Created by Maxim Alekseev on 11.02.2021.
//

import UIKit
import MapKit


protocol MapViewProtocol: class {
    var interactor: MapInteractorProtocol! { get set }
    var promoDescriptionBackground: UIImage? { get set }
    func showTariffPageVieController(_ tariffs: [TariffData])
    
    func updateData()
}


class MapViewController: UIViewController {
    
    //MARK: - Properties
    
    var interactor: MapInteractorProtocol!
    
    var promoDescriptionBackground: UIImage?
    
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var menuButton: MapRoundButton!
    @IBOutlet weak var lkButton: MapRoundButton!
    @IBOutlet weak var mapCenterButton: MapRoundButton!
    @IBOutlet weak var taxiButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var bottomView: MapBottomView!
    @IBOutlet weak var menuView: MenuView!
    @IBOutlet var promoDestinationView: PromoDestinationView!
    @IBOutlet weak var inactiveView: UIView!
    @IBOutlet weak var leadingLeftSideViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingLeftSideViewConstraint: NSLayoutConstraint!
    @IBOutlet var topPromoDestinationViewConstraint: NSLayoutConstraint!
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = MapInteractor(view: self)
        self.initViewSetup()
        self.minimizeMenuView()
        self.minimizePromoDestinationView()
        
           DispatchQueue.global(qos: .background).async {

            self.interactor.getAllPromos()
            

//            self.showPromos()

        }
        
        

        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //MARK: - IBActions
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
        self.inactiveView.alpha = MapInactiveViewAlpha.active.rawValue
        self.animateMenuViewMaximizing()

    }
    
    
    @IBAction func lkButtonTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func mapCenterButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func taxiButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func foodButtonTapped(_ sender: UIButton) {
        
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
    
    }

    private func initPromoDestinationViewSetUp() {
        self.inactiveView.alpha = 0
        self.promoDestinationView.alpha = 0
    }
    
    private func minimizeMenuView() {
        self.leadingLeftSideViewConstraint.constant = -UIScreen.main.bounds.width
        self.trailingLeftSideViewConstraint.constant = UIScreen.main.bounds.width
    }
    
    private func maximizeMenuView() {
        self.leadingLeftSideViewConstraint.constant = 0
        self.trailingLeftSideViewConstraint.constant = MapViewControllerConstraintsData.maximizedTrailingMenuViewConstant.rawValue
    }
    
    private func minimizePromoDestinationView() {
        self.topPromoDestinationViewConstraint.constant = -UIScreen.main.bounds.height
   
    }
    
    private func maximizePromoDestinationView() {
        self.topPromoDestinationViewConstraint.constant = MapViewControllerConstraintsData.maximizedTopPromoDestinationViewConstant.rawValue
    }
    
    
    //Remove left menu
    private func removeMenuView() {
        self.minimizeMenuView()
        self.inactiveView.alpha = MapInactiveViewAlpha.inactive.rawValue
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
//MARK: - MapViewProtocol
extension MapViewController: MapViewProtocol {

    func showTariffPageVieController(_ tariffs: [TariffData]) {
        let storyboard = UIStoryboard(name: StoryBoards.Tarifs.rawValue, bundle: nil)
        DispatchQueue.main.async {
            let tariffPageVC = storyboard.instantiateInitialViewController() as! TariffsPageViewController
            tariffPageVC.interactor = TariffPageInteractor(view: tariffPageVC, tariffs: tariffs)
            self.minimizeMenuView()
            self.inactiveView.alpha = MapInactiveViewAlpha.inactive.rawValue
            self.navigationController?.pushViewController(tariffPageVC, animated: true)
        }
        
    }
    
    func updateData() {
        
        DispatchQueue.main.async {
            
            guard let promos = self.interactor.promos else {return}
            
            for promo in promos {
                
                if self.interactor.isPromoAvailableByTime(timeFrom: promo.timeFrom ?? "", timeTo: promo.timeTo ?? "") == true {
                    self.promoDestinationView.alpha = 1
                    self.promoDestinationView.imageView.webImage(promo.media[1].url ?? "")
                    self.promoDestinationView.nameLabel.text = promo.title
                    print("promotitle")
                    print( promo.title)
                    
                    
                    
                }
            
            }

        }
           
    }
}

//MARK: - MenuViewDelegate

extension MapViewController: MenuViewDelegate {
    
    func performSegue(_ type: MapViewControllerSegue) {
        switch type {
        
        case .Tariffs:
            self.interactor.getTarifs()
            
        case .Settings:
            let storyboard = UIStoryboard(name: StoryBoards.Settings.rawValue, bundle: nil)
             let vc = storyboard.instantiateViewController(identifier: ViewControllers.SettingsViewController.rawValue)
             self.removeMenuView()
             self.navigationController?.pushViewController(vc, animated: true)
        case .unknown:
            break
  
        }
    }
}
