//
//  AddressEnterDetailView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 23.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class AddressEnterDetailView: UIView {
    
    //MARK: - Properties
    
    weak var delegate: AddressEnterDetailViewDelegate?
    
    private var viewType: AddressEnterDetailViewType?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var topStackView: UIStackView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var pinLabelImageView: UIImageView!
    
    @IBOutlet weak var pinTextFieldImageView: UIImageView!
    
    @IBOutlet weak var pinTextFieldView: UIView!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var mainButton: MainBottomButton!
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }
    
    //MARK: - @IBActions
    
    @IBAction func locationTextFieldEdited(_ sender: UITextField) {
        
    }
    
    @IBAction func mainButtonTapped(_ sender: MainBottomButton) {
        guard let text = locationTextField.text else {  return }
        self.delegate?.mainButtonTapped(text)
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
    
    private func initSubviews() {
        
        self.loadFromNib(nibName: AddressEnterDetailViewStringData.nibName.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        self.mainButton.setupAs(.approve)
        self.locationTextField.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    public func setupAs(_ type: AddressEnterDetailViewType) {
        
        self.viewType = type
        
        switch type {
        
        case .addressFrom(let sourceAddress):
            self.configureViewAsAddressFrom(sourceAddress)
        case .addressTo:
            self.configureViewAsAddressTo()
        case .showDestination(let destinationAddressText):
            self.configureViewAsShowDestination(destinationAddressText)
        }
    }
    
    public func setupLocationLabelText(_ text: String?) {
        self.locationLabel.text = text ?? "..."
    }
    
    public func setupLocationTextFieldText(_ text: String?) {
        self.locationTextField.text = text ?? "..."
    }
    
    //Configure view when AddressEnterDetailViewType.addressFrom selected
    private func configureViewAsAddressFrom(_ sourceAddress: String?) {
        self.locationTextField.placeholder = AddressesEnterDetailViewTexts.locationFromTextFieldPlaceholder
        self.locationTextField.addBottomBorder(color: Colors.buttonBlue.getColor())
        self.pinTextFieldView.isHidden = true
        self.pinLabelImageView.image = UIImage(named: CustomImagesNames.userPin.rawValue)
        self.locationTextField.becomeFirstResponder()
        self.mainButton.setupAs(.skip)
        self.locationLabel.text = sourceAddress
    }
    
    //Configure view when AddressEnterDetailViewType.addressTo selected
    private func configureViewAsAddressTo() {
        self.locationTextField.placeholder = AddressesEnterDetailViewTexts.locationToTextFieldPlaceholder
        self.locationTextField.addBottomBorder(color: Colors.taxiOrange.getColor())
        self.pinTextFieldView.isHidden = true
        self.pinLabelImageView.image = UIImage(named: CustomImagesNames.userPinOrange.rawValue)
        self.mainButton.setActive()
    }
    
    
    //Configure view when AddressEnterDetailViewType.showDestination selected
    private func configureViewAsShowDestination(_ destinationAddress: String?) {
        if let destinationAddress = destinationAddress {
            self.locationTextField.text = destinationAddress
        } else {
            self.locationTextField.text = "..."
        }
        self.locationTextField.addBottomBorder(color: Colors.taxiOrange.getColor())
        self.pinTextFieldView.isHidden = false
        self.topStackView.isHidden = true
        self.pinTextFieldImageView.image = UIImage(named: CustomImagesNames.userPinOrange.rawValue)
        self.mainButton.setActive()
    }
}

//MARK:  -

extension AddressEnterDetailView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let viewType = viewType else { return false }
        
        switch viewType {
        
        case .addressFrom(_):
            
            if let text = textField.text, text.count > 1 {
                self.mainButton.setupAs(.approve)
                self.mainButton.setActive()
            } else {
                self.mainButton.setupAs(.skip)
            }
            
        default:
            break
        }
        
        return true
    }
}
