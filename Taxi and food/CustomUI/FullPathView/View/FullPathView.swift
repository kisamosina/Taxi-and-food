//
//  FullPathView.swift
//  Taxi and food
//
//  Created by mac on 09/04/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class FullPathView: UIView {
    
    //MARK: - Properties
    
    weak var delegate: FullPathViewDelegate!
    
    var tariffOptions: [FullPathCellData] = []
    
    var mytariffOptions: [FullPathCellData] = []
    
    var type: FullPathViewType! {
        didSet {
            guard let type = type else { return }
            
            switch type {
                
            case .address:
                self.promoAndPointsStackView.isHidden = true
                self.collectionView.isHidden = true
                self.mainButton.setupAs(.next)
                self.mainButton.setActive()
                
            case .withTariff:
                self.promoAndPointsStackView.isHidden = false
                self.collectionView.isHidden = false
                self.mainButton.setupAs(.order)
                

//
            case .whenPoints(let pointsData):
                

//                self.setUpWhenPoints(pointsData)
                self.mainButton.setupAs(.order)
                
                
            }
        }
    }
    
    var pointsSpent: String = FullPathViewTexts.pointsLabel {
        didSet {
        
            self.pointsViewLabel.text = pointsSpent
        }
    }
    
    var promoDiscount: Int? {
        didSet {
            guard let discount = promoDiscount else { return }
            self.promoDiscountLabel.text = String(discount)
        }
    }

  
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var topView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var promoAndPointsStackView: UIStackView!
    @IBOutlet var mainButton: MainBottomButton!
    
    @IBOutlet var addressFromTextfield: UITextField!
    @IBOutlet var addressToTextfield: UITextField!
    @IBOutlet weak var mapButtonView: MapButtonView!
    @IBOutlet var promocodeViewLabel: UILabel!
    @IBOutlet var pointsViewLabel: UILabel!
    @IBOutlet var promoView: UIView!
    @IBOutlet var pointsView: UIView!
    @IBOutlet var promoDiscountLabel: UILabel!
    @IBOutlet var pointsToUseLabel: UILabel!
    @IBOutlet var pointsIcone: UIImageView!
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
        self.initCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
        self.initCollectionView()
    }
    
    //MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Layout setup
        self.contentView.layer.cornerRadius = TransitionBottomViewSizes.cornerRadius.rawValue
        self.contentView.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.contentView.layer.shadowOpacity = Float(TransitionBottomViewSizes.shadowOpacity.rawValue)
        self.contentView.layer.shadowRadius = TransitionBottomViewSizes.cornerRadius.rawValue
        self.contentView.layer.shadowOffset = CGSize(width: TransitionBottomViewSizes.shadowOffsetWidth.rawValue,
                                                     height: TransitionBottomViewSizes.shadowOffsetWidth.rawValue)
        self.contentView.layer.masksToBounds = false
        self.topView.layer.cornerRadius = self.topView.frame.height/2
        self.topView.clipsToBounds = true
        
        self.collectionView.delaysContentTouches = false
        self.collectionView.allowsSelection = true
        self.collectionView.allowsMultipleSelection = true

    }
    
    private func initCollectionView() {
      let nib = UINib(nibName: "FullPathCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "FullPathCollectionViewCell")
        collectionView.dataSource = self

    }
    
    private func initSubviews() {
        
        self.loadFromNib(nibName: FullPathViewStringData.nibName.rawValue)
        
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        self.configureTariffOptions()
        
        self.addressFromTextfield.addBottomBorder(color: Colors.buttonBlue.getColor())
        self.addressToTextfield.addBottomBorder(color: Colors.taxiOrange.getColor())
        self.promocodeViewLabel.text = FullPathViewTexts.promoLabel
//        self.pointsViewLabel.text = FullPathViewTexts.pointsLabel
//        promoView
        self.promoView.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.promoView.layer.shadowOffset = CGSize(width: AdvantageViewShadowsData.shadowOffsetWidth.rawValue,
                                         height: AdvantageViewShadowsData.shadowOffsetWidth.rawValue)
        self.promoView.layer.shadowRadius = AdvantageViewShadowsData.shadowRadius.rawValue
        self.promoView.layer.shadowOpacity = Float(AdvantageViewShadowsData.shadowOpacity.rawValue)
        self.promoView.layer.masksToBounds = false
        self.promoDiscountLabel.isHidden = true
//        pointsView
        self.pointsView.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.pointsView.layer.shadowOffset = CGSize(width: AdvantageViewShadowsData.shadowOffsetWidth.rawValue,
                                         height: AdvantageViewShadowsData.shadowOffsetWidth.rawValue)
        self.pointsView.layer.shadowRadius = AdvantageViewShadowsData.shadowRadius.rawValue
        self.pointsView.layer.shadowOpacity = Float(AdvantageViewShadowsData.shadowOpacity.rawValue)
        self.pointsView.layer.masksToBounds = false
        self.promoDiscountLabel.isHidden = true
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
        private func configureTariffOptions() {
            
            guard let standartIcon = UIImage(named: "iconStandart") else { return }
            guard let premiumIcon = UIImage(named: "iconPremium") else { return }
            guard let businessIcon = UIImage(named: "iconBusiness") else { return }
            
    //        fix title naming and getting data
            self.mytariffOptions.append(FullPathCellData(title: "Standart", icon: standartIcon, duration: "3 мин", cost: "100 руб", color: Colors.tariffGreen.getColor()))
            self.mytariffOptions.append(FullPathCellData(title: "Premium", icon: premiumIcon, duration: "8 мин", cost: "250 руб", color: Colors.tariffPurple.getColor()))
            self.mytariffOptions.append(FullPathCellData(title: "Business", icon: businessIcon, duration: "14 мин", cost: "430 руб", color: Colors.tariffGold.getColor()))

        }
    
    public func setTariffOptions(_ options: [FullPathCellData]) {
        self.tariffOptions = options
        self.collectionView.reloadData()
        collectionView.allowsMultipleSelection = false
//        collectionView.selectItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, animated: false, scrollPosition: .left)
    }
    
    private func setUpWhenPoints(_ pointsData: String) {
        self.pointsToUseLabel.isHidden = true
        self.pointsIcone.isHidden = true
        
        let pointsString = String(pointsData)
        let text = FullPathViewTexts.minusPointsText.insert(text: pointsString)
        self.pointsViewLabel.text = text
        self.pointsViewLabel.setBoldAndGreen(forText: pointsString + " " + FullPathViewTexts.minusPointsText.selectedSuffixText())
        
//        self.pointsToUseLabel.text = String(pointsData)
//        self.pointsViewLabel.text = FullPathViewTexts.pointsLabelChanged
        
    }
    
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        self.delegate.nextButtonDidTapped()
        
    }
    @IBAction func promoButtonTapped(_ sender: Any) {
        self.delegate.promoButtonDidTapped()
        print("promoTapped")
    }
    
    @IBAction func pointsButtonDidTapped(_ sender: Any) {
        self.delegate.pointsButtonDidTapped()
    }
    
    public func setView(as type: FullPathViewType ) {
        self.type = type
    }
    
    func setupAddress(from: String, to: String) {
        
        self.addressFromTextfield.text = from
        self.addressToTextfield.text = to
    }
    
}



extension FullPathView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullPathCollectionViewCell", for: indexPath) as? FullPathCollectionViewCell else { return UICollectionViewCell() }
        
        cell.showData(for: mytariffOptions[indexPath.row])
        
//        if(indexPath.row == 0) { //for first cell in the collection
//            cell.backgroundColor = UIColor.white
//        } else {
//            cell.backgroundColor = Colors.backGroundGreyActive.getColor()
//        }
        
        return cell
    }
    
    
    
}
