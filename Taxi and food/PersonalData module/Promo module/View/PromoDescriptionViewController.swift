//
//  PromoDescriptionViewController.swift
//  Taxi and food
//
//  Created by mac on 26/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit


import UIKit


protocol PromoDescriptionViewProtocol: class {
    var interactor: PromoDescriptionIneractorProtocol! { get set }
    
    func refresh()

}

class PromoDescriptionViewController: UIViewController {
    
    
    @IBOutlet var unavailableLabel: UILabel!
    @IBOutlet weak var buyButton: MainBottomButton!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var id: Int?
    var data: [PromoFullData] = []
    var availableByDate: Bool!
    var availableByTime: Bool!
    
  
   
    var interactor: PromoDescriptionIneractorProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.interactor = PromoDescriptionInteractor(view: self)
        
        interactor.getPromosDescription(for: id!)

        setUp()
 
    }
    @IBAction func buyButtonTapped(_ sender: Any) {
        
        if availableByTime == true { performSegue() } else {
             self.unavailableLabel.text = PromoViewControllerText.unavailableLabelTitleText
        }
        
    }
    


    func setUp() {

        view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            
        ])
        
        nameLabel.text = ""
        descriptionLabel.text = ""
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        nameLabel.sizeToFit()
        unavailableLabel.text = ""
        unavailableLabel.numberOfLines = 2
        unavailableLabel.textColor = .white
       
    
    }

}

extension PromoDescriptionViewController: PromoDescriptionViewProtocol {
    func refresh() {
        DispatchQueue.main.async {
        
            
            self.nameLabel.text = self.interactor.promo?.title
            self.descriptionLabel.text = self.interactor.promo?.description
            self.buyButton.setupAs(.goBuy)
            
            self.imageView.webImage(self.interactor.promo?.media[0].url ?? "")
            
            self.availableByDate = self.interactor.isPromoAvailableByDate()
            self.availableByTime = self.interactor.isPromoAvailableByTime(timeFrom:
                self.interactor.promo?.timeFrom ?? "", timeTo: self.interactor.promo?.timeFrom ?? "")

   
        }
    }
    
}

extension PromoDescriptionViewController {
    
    func performSegue() {
        let storyboard = UIStoryboard(name: StoryBoards.AuthAndMap.rawValue, bundle: nil)

        let vc = storyboard.instantiateViewController(identifier: ViewControllers.MapViewController.rawValue)
        self.navigationController?.pushViewController(vc, animated: true)
}
    

}
