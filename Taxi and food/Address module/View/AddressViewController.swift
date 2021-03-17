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
    
    @IBOutlet var chooseDestinationButton: MainBottomButton!
    @IBOutlet var deleteButton: MainBottomButton!
    
    
    internal var interactor: AddressInteractorProtocol!
    
    private var addressFromMap: String?
    var destination: Bool = false
    
    var arrayOfTextFields: [UITextField]!
    var navigationItemNewName: String?
    
    var scrollViewPoint = CGPoint(x: 0, y: 0)
    
    var addressInfo: AddressResponseData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.contentOffset = CGPoint(x: 0, y: 0)

        configureUI()
        configureTextFields()
        addTextFieldsTargets()
        
        self.interactor = AddressInteractor(view: self)
        
        
        chooseDestinationButton.isHidden = true
        deleteButton.isHidden = true
        
        addressNameTextField.isHidden = false
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //        Checking data presence
        if addressInfo != nil {
            chooseDestinationButton.isHidden = false
            deleteButton.isHidden = false
            addressNameTextField.isHidden = true
            saveButton.isHidden = false
        }
        
        
        
//        Confuguring textfields
        self.navigationItem.title = addressInfo?.name
        
        self.addressTextField.text = addressInfo?.address
        self.commentDriverTextField.text = addressInfo?.commentDriver
        
        if let userFlat = addressInfo?.flat {
            self.officeTextField.text = String(userFlat)
        }
        if let userEntrance = addressInfo?.entrance {
            self.entranceTextField.text = String(userEntrance)
        }
        if let userIntercom = addressInfo?.intercom {
            self.intercomTextField.text = String(userIntercom)
        }
        if let userFloor = addressInfo?.floor {
            self.floorTextField.text = String(userFloor)
        }
        self.commenCourierTextField.text = addressInfo?.commentCourier

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
        self.saveButton.setTitle(MainButtonTitles.saveButtonTitle, for: .normal)
    
        self.mapButton.tintColor = .black
        self.mapButton.setTitle(AddressViewControllerText.mapButtonTitleText, for: .normal)
        
        self.deleteButton.setupAs(.delete)
        self.deleteButton.tintColor = .black
        self.deleteButton.backgroundColor = .white
        self.deleteButton.setTitle(MainButtonTitles.deleteButtonTitle, for: .normal)
        
        self.chooseDestinationButton.setupAs(.chooseDestination)
        self.chooseDestinationButton.backgroundColor = Colors.buttonBlue.getColor()
        self.chooseDestinationButton.tintColor = .white
        self.chooseDestinationButton.setTitle(MainButtonTitles.chooseDestinationButtonTitle, for: .normal)

    }
    
    func configureTextFields() {
        
        arrayOfTextFields = [addressNameTextField,addressTextField, commentDriverTextField, officeTextField, officeTextField, entranceTextField, intercomTextField, floorTextField, commenCourierTextField]
 
        arrayOfTextFields.map { $0.addBottomBorder(color: Colors.buttonGrey.getColor()) }
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
    @IBAction func chooseDestinationTapped(_ sender: Any) {
        
        self.destination = true
        
        
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
        self.interactor.changeAddress(with: addressInfo?.id ?? 0, with: ["name": addressInfo?.name, "address": addressInfo?.address, "commentDriver": addressInfo?.commentDriver, "commentCourier": addressInfo?.commentCourier , "flat": addressInfo?.flat , "intercom": addressInfo?.intercom, "entrance": addressInfo?.entrance, "floor": addressInfo?.floor, "destination": addressInfo?.destination])
        
        
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
        
        self.floorTextField.keyboardType = .decimalPad

        
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


