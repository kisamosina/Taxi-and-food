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
    @IBOutlet weak var menuButton: MapRoundButton!
    @IBOutlet weak var lkButton: MapRoundButton!
    @IBOutlet weak var mapCenterButton: MapRoundButton!
    @IBOutlet weak var taxiButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var bottomView: MapBottomView!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

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
        

}
