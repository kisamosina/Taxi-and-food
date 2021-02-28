//
//  PromoDescriptionViewController.swift
//  Taxi and food
//
//  Created by mac on 26/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PromoDescriptionViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var buyButton: UIButton!
    
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("id")
        print(id)
        
//        showBackground(for: self.media ?? PromoMedia(url: "", file_name: ""))
       
       
    }
    
//    func showBackground(for media: PromoMedia) {
//
//        NetworkService.shared.loadImageData(for: media.url ?? "") { [weak self] result in
//            guard let self = self  else { return }
//
//            switch result {
//            case .success(let imgData):
//                let image = UIImage(data: imgData)
//                print("success")
//                self.view.backgroundColor = UIColor(patternImage: image ?? UIImage())
//            case .failure(let error):
//                print("Error while load advantage image: \(error.localizedDescription)")
//            }
//        }
//
//    }
    
    func setUp() {
//
//        showBackground(for: media ?? PromoMedia(url: "", file_name: "") )

        
       
        
      
        
    }

}
