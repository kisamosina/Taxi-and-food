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
}


class MapViewController: UIViewController {
    
    //MARK: - Properties
    
    var interactor: MapInteractorProtocol!
    
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
        
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

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
    
    //MARK: - Methods
    
    private func initViewSetup() {
        self.inactiveView.alpha = 0
        self.menuView.alpha = 0
        self.menuView.setupView(with: interactor.mapMenuData)
    }
    
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
    
}

extension MapViewController: MapViewProtocol { }
