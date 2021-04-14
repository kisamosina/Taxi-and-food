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
            }
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
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
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
        
    }
    
    private func initCollectionView() {
      let nib = UINib(nibName: "FullPathCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "FullPathCollectionViewCell")
        collectionView.dataSource = self
    }
    
    private func initSubviews() {
        
        self.loadFromNib(nibName: FullPathViewStringData.nibName.rawValue)
        
        var nib = UINib(nibName: "FullPathCollectionViewCell", bundle:nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "FullPathCollectionViewCell")
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        self.configureTariffOptions()
        
        self.addressFromTextfield.addBottomBorder(color: Colors.buttonBlue.getColor())
        self.addressToTextfield.addBottomBorder(color: Colors.taxiOrange.getColor())
        self.promocodeViewLabel.text = FullPathViewTexts.promoLabel
        self.pointsViewLabel.text = FullPathViewTexts.pointsLabel
//        self.mainButton.setupAs(.approve)
//        self.locationTextField.delegate = self
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
    }
    
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        self.delegate.nextButtonDidTapped()
        
    }
    
    public func setView(as type: FullPathViewType ) {
        self.type = type
    }
    
    func setupAddress(from: String, to: String) {
        
        self.addressFromTextfield.text = from
        self.addressToTextfield.text = to
    }
    
}



extension FullPathView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullPathCollectionViewCell", for: indexPath) as? FullPathCollectionViewCell else { return UICollectionViewCell() }
        
        cell.showData(for: mytariffOptions[indexPath.row])
        
        return cell
    }
    
    
}
