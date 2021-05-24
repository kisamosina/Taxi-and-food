//
//  PersonalDataViewController.swift
//  Taxi and food
//
//  Created by mac on 21/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol PersonalDataViewProtocol: AnyObject {
    var interactor: PersonalDataInteractorProtocol! { get set }
}
class PersonalDataViewController: UIViewController {
    
    @IBOutlet var policyLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var containerView = UIView()
    var slideUpView = UITableView()
    let slideUpViewHeight: CGFloat = 200
    
    var interactor: PersonalDataInteractorProtocol!
    var models: [PersonalDataSection]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPolicyLabelGestureRecognizer()
        
        self.interactor = PersonalDataInteractor(view: self)
        self.interactor.configure()
        
        //FIXME: rename identifier
        tableView.register(PersonalDataCell.self, forCellReuseIdentifier: "personalData")

        confugureLabel()
        
    }
    
    //MARK: - Methods

    func confugureLabel() {
        policyLabel.text = PersonalDataViewControllerText.policyLabelText
        
        //MARK: - set attributed text
        policyLabel.setAttributedText(PersonalDataViewControllerText.userArgeement)
        policyLabel.setAttributedText(PersonalDataViewControllerText.privacyPolicy)
    }
    
    private func addPolicyLabelGestureRecognizer() {
        policyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapPolicyLabel(gesture:))))
    }
    
    @objc func slideUpViewTapped() {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
          self.containerView.alpha = 0
          self.slideUpView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.slideUpViewHeight)
        }, completion: nil)
    }
    
    @objc func showSlideUpView() {
        print("show slide up view")
        
        let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
        
        

        
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        containerView.frame = self.view.frame
        keyWindow?.addSubview(containerView)
        
        
        
        
        let screenSize = UIScreen.main.bounds.size
        slideUpView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: slideUpViewHeight)
        slideUpView.separatorStyle = .none
        keyWindow?.addSubview(slideUpView)
        
        
        let tapGesture = UITapGestureRecognizer(target: self,
        action: #selector(slideUpViewTapped))
        containerView.addGestureRecognizer(tapGesture)
        
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
          self.containerView.alpha = 0.8
          self.slideUpView.frame = CGRect(x: 0, y: screenSize.height - self.slideUpViewHeight, width: screenSize.width, height: self.slideUpViewHeight)
        }, completion: nil)
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
  
}

extension PersonalDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = interactor.models[section]
        return section.tittle
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
        cell.configure(with: model)
        
        cell.textField.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(showSlideUpView)))
            
        return cell
    }
    
    
}

extension PersonalDataViewController: PersonalDataViewProtocol {}
