//
//  MainViewController.swift
//  Ride and food
//
//  Created by Maxim Alekseev on 11.02.2021.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var lkButton: UIButton!
    @IBOutlet weak var mapCenterButton: UIButton!
    @IBOutlet weak var taxiButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupButtonsAppearence()
        
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
    
    private func setupButtonsAppearence() {
        self.menuButton.setupRoundedButton()
        self.lkButton.setupRoundedButton()
        self.mapCenterButton.setupRoundedButton()
    }
    
    
}
