//
//  PersonalDataViewController.swift
//  Taxi and food
//
//  Created by mac on 21/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol PersonalDataViewProtocol: class {
    var interactor: PersonalDataInteractorProtocol! { get set }
}
class PersonalDataViewController: UIViewController {

    @IBOutlet var transitionView: PersonalDataBottomView!
    
    @IBOutlet var policyLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var personalDataViewBottomConstraint: NSLayoutConstraint!
    
    
    var interactor: PersonalDataInteractorProtocol!
    var models: [PersonalDataUISection]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPolicyLabelGestureRecognizer()
        self.addKeyboardWillShowObserver()
        
        self.interactor = PersonalDataInteractor(view: self)
        self.interactor.configure()
        
        //FIXME: rename identifier
        tableView.register(PersonalDataCell.self, forCellReuseIdentifier: "personalData")

        confugureLabel()
        self.setupTextView()
        
    }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }

    
    
    //MARK: - Methods
    
    private func setupTextView() {
       
        personalDataViewBottomConstraint = self.transitionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        print("when set up")
        print(personalDataViewBottomConstraint.constant)

        NSLayoutConstraint.activate([
            self.personalDataViewBottomConstraint,
            self.transitionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.transitionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.transitionView.heightAnchor.constraint(equalToConstant: TextEnterViewSize.height.rawValue)

        ])
    }

    func confugureLabel() {
        policyLabel.text = PersonalDataViewControllerText.policyLabelText
        
        //MARK: - set attributed text
        policyLabel.setAttributedText(PersonalDataViewControllerText.userArgeement)
        policyLabel.setAttributedText(PersonalDataViewControllerText.privacyPolicy)
    }
    
    private func addKeyboardWillShowObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillAppear(notification: NSNotification) {
        keyboardWillShowReverse(constraint: personalDataViewBottomConstraint, notification: notification, selfHeight: self.transitionView.frame.height)
        print("keyboard appeared")
        print(personalDataViewBottomConstraint.constant)
        
    }
    
    @objc private func keyboardWillDisappear(notification: NSNotification) {
        keyboardWillHide(constraint: personalDataViewBottomConstraint, notification: notification)
        
        print("keyboard dissapeared")
        print(personalDataViewBottomConstraint.constant)
    }
    
    private func addPolicyLabelGestureRecognizer() {
        policyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapPolicyLabel(gesture:))))
    }

    
    @objc func tapPolicyLabel(gesture: UITapGestureRecognizer) {
        guard let text = policyLabel.text else { return }
        
        let rangeUA = (text as NSString).range(of: PersonalDataViewControllerText.userArgeement)
        let rangePP = (text as NSString).range(of: PersonalDataViewControllerText.privacyPolicy)
        
        if gesture.didTapAttributedTextInLabel(label: policyLabel, inRange: rangeUA) {
            
            //TODO: rename identifier
            
            guard let uaVC = storyboard?.instantiateViewController(identifier: "userAgreement")
            else { return }
            self.present(uaVC, animated: true, completion: nil)
            
        }
        if gesture.didTapAttributedTextInLabel(label: policyLabel, inRange: rangePP) {
            guard let ppVC = storyboard?.instantiateViewController(identifier: "privacyPolicy")
                else { return }
            self.present(ppVC, animated: true, completion: nil)
        }
        
    }
    
    @objc func showSlideUpView() {
        
//        let storyboard = UIStoryboard(name: StoryBoards.Promocode.rawValue, bundle: nil)
//
//
//        let vc = storyboard.instantiateViewController(identifier: ViewControllers.PromocodeEnterViewController.rawValue)
//        self.navigationController?.pushViewController(vc, animated: true)
//
        
        guard let vc = getViewController(storyboardId: StoryBoards.Inactive.rawValue, viewControllerId: ViewControllers.InactiveViewController.rawValue) as? InactiveViewController else { return }
        vc.setState(.showEnterPersonalDataView)
//        vc.delegate = self
        self.present(vc, animated: false)
        print("textfield tapped")
        
        
    }
  
}

extension PersonalDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = interactor.models[section]
        return section.placeholder
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor.models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = interactor.models[indexPath.section].options[indexPath.row]
        

        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonalDataCell.identifier, for: indexPath) as? PersonalDataCell else {
            return UITableViewCell()
        }
        cell.configureUI(with: model)
        
//        if let data = interactor.personalDataTableViewData {
//            cell.configureData(with: data)
//        }
        cell.textField.addTarget(self, action: #selector(showSlideUpView), for: .editingDidBegin)
            
        return cell
    }
    
    
}

extension PersonalDataViewController: PersonalDataViewProtocol {}
