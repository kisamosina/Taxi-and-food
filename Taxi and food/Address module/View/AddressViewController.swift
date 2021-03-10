//
//  AddressViewController.swift
//  Taxi and food
//
//  Created by mac on 05/03/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol AddressViewProtocol: class {
    var interactor: AddressInteractorProtocol! { get set }
    
}

class AddressViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var addressNameTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var commentDriverTextField: UITextField!
    
    @IBOutlet var deliveryLabel: UILabel!
    
    @IBOutlet var officeTextField: UITextField!
    @IBOutlet var entranceTextField: UITextField!
    @IBOutlet var intercomTextField: UITextField!
    @IBOutlet var floorTextField: UITextField!
    @IBOutlet var commenCourierTextField: UITextField!
    
    @IBOutlet var saveButton: MainBottomButton!
    @IBOutlet var mapButton: UIButton!
    
    internal var interactor: AddressInteractorProtocol!
    
    private let rawName: String? = nil
    private let rawAddress: String? = nil
    private let rawCommentDriver: String? = nil
    private let rawCommentCourier: String? = nil
    private let rawFlat: Int? = nil
    private let rawIntercom: Int? = nil
    private let rawEntrance: Int? = nil
    private let rawFloor: Int? = nil
    private let rawDestination: Bool? = nil
    
    var userStreet: String?
    var userHouse: String?
    
    var arrayOfTextFields: [UITextField]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self

        configureUI()
        configureTextFields()
        
        self.interactor = AddressInteractor(view: self, name: self.rawName, address: self.rawAddress, commentDriver: self.rawCommentDriver, commentCourier: self.rawCommentCourier, flat: self.rawFlat, intercom: self.rawIntercom, entrance: self.rawEntrance, floor: self.rawFloor, destination: self.rawDestination)
        
    }
    
    func configureUI() {
        self.navigationItem.title = AddressViewControllerText.navigationItemNewTitleText
        self.addressNameTextField.placeholder = TextFieldsPlaceholderText.nameAddressText
        self.addressTextField.placeholder = TextFieldsPlaceholderText.addressText
        self.commentDriverTextField.placeholder = TextFieldsPlaceholderText.commentForDriverText
        self.officeTextField.placeholder = TextFieldsPlaceholderText.officeText
        self.entranceTextField.placeholder = TextFieldsPlaceholderText.entranceText
        self.intercomTextField.placeholder = TextFieldsPlaceholderText.intercomText
        self.floorTextField.placeholder = TextFieldsPlaceholderText.floorText
        self.commenCourierTextField.placeholder = TextFieldsPlaceholderText.commenForCourierText
        self.deliveryLabel.text = AddressViewControllerText.deliveryLabelText

        self.saveButton.setupAs(.save)
        self.saveButton.backgroundColor = Colors.buttonBlue.getColor()
        self.saveButton.tintColor = .white
        
        self.mapButton.setTitle(AddressViewControllerText.mapButtonTitleText, for: .normal)
        self.mapButton.tintColor = .black

    }
    
    func configureTextFields() {
        
        arrayOfTextFields = [addressNameTextField,addressTextField, commentDriverTextField, officeTextField, officeTextField, entranceTextField, intercomTextField, floorTextField, commenCourierTextField]
 
        arrayOfTextFields.map { $0.addBottomBorder() }
        arrayOfTextFields.map { $0.delegate = self }
        

    }
    
    private func addTextFieldsTargets() {
        addressNameTextField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        addressTextField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        commentDriverTextField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        officeTextField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        entranceTextField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        intercomTextField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        floorTextField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        commenCourierTextField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        
        
        
    }
    
    @objc private func textDidChange(textField: UITextField) {
        
        let text = textField.text
        print("text")
        print(text)
        interactor.sendAddressRequest()
        
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
    }

}

extension AddressViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
   
}

extension AddressViewController: AddressViewProtocol {}


