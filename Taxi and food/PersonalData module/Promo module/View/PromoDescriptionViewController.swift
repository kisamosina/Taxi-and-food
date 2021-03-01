//
//  PromoDescriptionViewController.swift
//  Taxi and food
//
//  Created by mac on 26/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol PromoDescriptionViewProtocol: class {
    var interactor: PromoDescriptionIneractorProtocol! { get set }
    
    func refresh()
    
}

class PromoDescriptionViewController: UIViewController {
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
    
    var interactor: PromoDescriptionIneractorProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("id")
        print(id)
        print(data)
        
        self.interactor = PromoDescriptionInteractor(view: self)
        
        interactor.getPromosDescription(for: id!)
        
        print("description")
        print(interactor.promo)
        
        setUp()
        
        
//        showBackground(for: self.media ?? PromoMedia(url: "", file_name: ""))
       
       
    }
    
    func showBackground(for media: PromoMedia) {

        NetworkService.shared.loadImageData(for: media.url ?? "") { [weak self] result in
            guard let self = self  else { return }

            switch result {
            case .success(let imgData):
                let image = UIImage(data: imgData)
                imageView.image = image
                print("success")
                
                
            case .failure(let error):
                print("Error while load advantage image: \(error.localizedDescription)")
            }
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
        
        self.buyButton.setupAs(.goBuy)
        
    
    }

}

extension PromoDescriptionViewController: PromoDescriptionViewProtocol {
    func refresh() {
        DispatchQueue.main.async {
        
            self.showBackground(for: self.interactor.promo?.media[0] ?? PromoMedia(url: "", file_name: ""))
            self.nameLabel.text = self.interactor.promo?.title
            self.descriptionLabel.text = self.interactor.promo?.description
        
        
            
        }
    }
    
}
