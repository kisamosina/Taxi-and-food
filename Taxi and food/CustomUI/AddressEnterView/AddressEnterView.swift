//
//  AddressEnterView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 16.03.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class AddressEnterView: UIView {
    
    //MARK: - Properties
    
    weak var delegate: AddressEnterViewDelegate?
    
    private var addresses: [AddressResponseData] = []
    
    //MARK: - IBOutlets

    @IBOutlet weak var topView: UIView!
        
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var addressFromTextField: UITextField!
    
    @IBOutlet weak var addressToTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nextButton: MainBottomButton!
    
    @IBOutlet weak var mapButtonView: MapButtonView!
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }
 //MARK: - IBActions
    
    @IBAction func userHasSwipedDown(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            self.delegate?.userHasSwipedViewDown()
        }
    }
    
    
    @IBAction func addressToTextFieldHasBecomeActive(_ sender: UITextField) {
        self.mapButtonView.isHidden = false
        self.tableView.isHidden = false
        self.delegate?.tableViewWillAppear()
        }
    
    
    
    @IBAction func addressToTextFieldDidEndEditing(_ sender: UITextField) {
        self.tableView.isHidden = true
        self.delegate?.tableViewWillDisappear()
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
        
        self.loadFromNib(nibName: AddressesViewNibsNames.AddressEnterView.rawValue)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        self.setupConstraints()
        self.nextButton.setupAs(.next)
        self.setupTableView()
        self.addressFromTextField.addBottomBorder(color: Colors.buttonBlue.getColor())
        self.addressToTextField.addBottomBorder(color: Colors.buttonGrey.getColor())
        self.addressToTextField.placeholder = AddressesEnterViewTexts.toLabelPlaceHolderText
        self.mapButtonView.delegate = self
        self.mapButtonView.isHidden = true
        self.tableView.isHidden = true
    }
    
    private func setupConstraints() {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: containerView.topAnchor),
                self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])
        }
    
    private func setupTableView() {
        let nib = UINib(nibName: AddressesViewNibsNames.AddressTableViewCell.rawValue, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: AddressesViewStringData.AddressTableViewCell.rawValue)
        self.tableView.tableFooterView = UIView()
    }
    
    public func setAddressFromTextFieldText(_ text: String? ){
        self.addressFromTextField.text = text
    }
    
    public func setAddresses(_ addresses: [AddressResponseData]) {
        self.addresses = addresses
        self.tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension AddressEnterView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressEnterViewStringData.addressTableViewCellReuseId.rawValue) as! AddressTableViewCell
        cell.setCell(by: self.addresses[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = addresses[indexPath.row]
        self.addressToTextField.text = address.address
    }
}

//MARK: - MapButtonViewDelegate

extension AddressEnterView: MapButtonViewDelegate {
    
    func mapButtonTapped() {
        self.delegate?.mapButtonViewTapped(destinationAddress: self.addressToTextField.text)
        self.endEditing(true)
    }
    
}
