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
    
    //MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var lkButton: UIButton!
    @IBOutlet weak var mapCenterButton: UIButton!
    @IBOutlet weak var taxiButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupButtonsAndViewAppearence()
        
    }
    
    //MARK: - IBActions
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func lkButtonTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func mapCenterButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func taxiButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func foodButtonTapped(_ sender: UIButton) {
        
    }
    //MARK: - Methods
    
    private func setupButtonsAndViewAppearence() {
        self.menuButton.setupRoundedButtonWithShadow()
        self.lkButton.setupRoundedButtonWithShadow()
        self.mapCenterButton.setupRoundedButtonWithShadow()
        self.bottomView.layer.cornerRadius = 20
        self.bottomView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.bottomView.layer.shadowOpacity = 1
        self.bottomView.layer.shadowRadius = 20
        self.bottomView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.bottomView.layer.masksToBounds = false
    }
    
    
}
