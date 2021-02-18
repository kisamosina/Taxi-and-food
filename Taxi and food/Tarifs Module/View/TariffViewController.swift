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

protocol TariffPageViewControllerDelegate: class {
    func setVC(for tariffName: String)
}

class TariffViewController: UIViewController {
    
    //MARK: - Properties
    
    internal var interactor: TariffInteractorProtocol!
    private var pageController: UIPageViewController?
    weak var tariffPageDelegate: TariffPageViewControllerDelegate?
    private var tariffButtons: [TariffTitleButton] = []
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var upBorderView: UIView!
    @IBOutlet weak var autoNamesLabel: UILabel!
    @IBOutlet weak var taxiImageView: UIImageView!
    @IBOutlet weak var aboutTarifLabel: UILabel!
    @IBOutlet weak var tarifDescriptionLabel: TopAlignedLabel!
    @IBOutlet weak var advantagesCollectionView: UICollectionView!
    @IBOutlet weak var orderButton: NextButton!
    @IBOutlet weak var tariffButtonsStackView: UIStackView!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.aboutTarifLabel.text = TariffViewControllerTextData.tariffDescriptionText
        self.setViewsData(interactor.tariff)
    }
    
    //MARK: - IBActions
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
    }
    
    //MARK: - Methods
    
    @objc func tariffButtonTapped(_ button: UIButton) {
        guard let title = button.title(for: .normal) else { return }
        self.tariffPageDelegate?.setVC(for: title)
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension TariffViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.tariff.advantages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = advantagesCollectionView.dequeueReusableCell(withReuseIdentifier: TariffsServiceTextData.AdavantageCollectionViewCell.rawValue,
                                                                      for: indexPath) as? AdvantageCollectionViewCell else { return UICollectionViewCell() }
        let tariffAdvantage = interactor.tariff.advantages[indexPath.row]
        cell.showData(for: tariffAdvantage, tariffColor: interactor.tariffColor)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let screenWidth = UIScreen.main.bounds.width
        let cellnumbersOnScreen: CGFloat = 3
        let workSpace = (screenWidth - AdvantageCollectionViewSizes.widthSumInsets.rawValue)/cellnumbersOnScreen
        return CGSize(width: workSpace, height: AdvantageCollectionViewSizes.cellHeight.rawValue)

    }

}

//MARK: - TarifViewProtocol

extension TariffViewController: TariffViewProtocol {
    
    func setViewsData(_ tariffData: TariffData) {
        
            self.tariffButtons = interactor.makeTariffsButtons()
            self.tariffButtons.forEach { [weak self] button in  self?.tariffButtonsStackView.addArrangedSubview(button)
                button.addTarget(self, action: #selector(tariffButtonTapped), for: .touchUpInside)
            }
            self.autoNamesLabel.text = TariffViewControllerTextData.autoNamesText + tariffData.cars
            self.autoNamesLabel.setBlackColor(TariffViewControllerTextData.autoNamesText)
            self.taxiImageView.webImage(tariffData.icon)
            self.tarifDescriptionLabel.text = tariffData.description
            self.upBorderView.backgroundColor = interactor.tariffColor
            self.advantagesCollectionView.reloadData()
            
    }
}

