//
//  TarifViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 17.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol TariffViewProtocol: class {
    var interactor: TariffInteractorProtocol! { get set }
    
    func setViewsData(_ tariffData: TariffData)
}

class TariffViewController: UIViewController {
    
    //MARK: - Properties
    
    internal var interactor: TariffInteractorProtocol!
    
    //MARK: - IBOutlets
    @IBOutlet weak var upBorderView: UIView!
    @IBOutlet weak var autoNamesLabel: UILabel!
    @IBOutlet weak var taxiImageView: UIImageView!
    @IBOutlet weak var aboutTarifLabel: UILabel!
    @IBOutlet weak var tarifDescriptionLabel: TopAlignedLabel!
    @IBOutlet weak var advantagesCollectionView: UICollectionView!
    @IBOutlet weak var orderButton: NextButton!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = TariffInteractor(view: self)
        self.interactor.getTarifs()
        self.aboutTarifLabel.text = TariffViewControllerTextData.tariffDescriptionText
    }
    
    //MARK: - IBActions
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension TariffViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.tariffAdvantages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = advantagesCollectionView.dequeueReusableCell(withReuseIdentifier: TariffsServiceTextData.AdavantageCollectionViewCell.rawValue,
                                                                      for: indexPath) as? AdvantageCollectionViewCell else { fatalError("AdavantageCollectionViewCell is not exist") }
        let tariffAdvantage = interactor.tariffAdvantages[indexPath.row]
        cell.showData(for: tariffAdvantage)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let screenWidth = UIScreen.main.bounds.width
        let cellnumbersOnScreen: CGFloat = 3
        let workSpace = (screenWidth - AdvantageCollectionViewInsets.widthSumInsets.rawValue)/cellnumbersOnScreen
        return CGSize(width: workSpace, height: 80)

    }

}

//MARK: - TarifViewProtocol

extension TariffViewController: TariffViewProtocol {
    
    func setViewsData(_ tariffData: TariffData) {
        DispatchQueue.main.async {
            self.autoNamesLabel.text = TariffViewControllerTextData.autoNamesText + tariffData.cars
            self.autoNamesLabel.setBlackColor(TariffViewControllerTextData.autoNamesText)
            self.taxiImageView.webImage(tariffData.icon)
            self.tarifDescriptionLabel.text = tariffData.description
            self.advantagesCollectionView.reloadData()
        }
    }
    
    
    
}

