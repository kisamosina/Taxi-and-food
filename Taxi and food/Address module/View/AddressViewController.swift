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
    
    private var addressFromMap: String?
    var destination: Bool = false
    
    var arrayOfTextFields: [UITextField]!
    
    var scrollViewPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.contentOffset = CGPoint(x: 0, y: 0)

        configureUI()
        configureTextFields()
        addTextFieldsTargets()
        
        self.interactor = AddressInteractor(view: self)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("address from map")
        print(addressFromMap)
        self.addressTextField.text = addressFromMap
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
    
    
    @IBAction func mapButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: ViewControllers.AppleMapViewController.rawValue, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ViewControllers.AppleMapViewController.rawValue {
            let vc = segue.destination as! AppleMapViewController
            vc.delegate = self
            
        }
    }
    
    @IBAction func seveButtonTapped(_ sender: Any) {

        print("want to save data")
        
        var address = addressTextField?.text
        
        if addressTextField?.text == nil {
            address = addressFromMap
        }
       

        self.interactor.sendAddressRequest(name: addressNameTextField?.text, address: address, commentDriver: commentDriverTextField?.text, commentCourier: commenCourierTextField?.text, flat: Int(officeTextField?.text ?? ""), intercom: Int(intercomTextField?.text ?? ""), entrance: Int(entranceTextField?.text ?? ""), floor: Int(floorTextField?.text ?? ""), destination: destination)
        
        performSegue(withIdentifier: ViewControllers.AllAddressesViewController.rawValue, sender: self)
    }
    
    @objc private func textDidChange(textField: UITextField) {
        
        let text = textField.text
        print("text")
        print(text)
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let point = CGPoint(x: 0.0, y: commenCourierTextField.frame.origin.y)
        scrollView.contentOffset = point
        print("point")
        print(point)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.contentOffset = scrollViewPoint
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
extension AddressViewController: AppleMapDelegateProtocol {
    func send(address: String) {
        self.addressFromMap = address
    }
    
    
}


