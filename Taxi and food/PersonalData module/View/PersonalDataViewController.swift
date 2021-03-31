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
        self.interactor = PersonalDataInteractor(view: self)
        self.interactor.configure()
        confugureLabel()
  
    }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
   
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewControllers.PersonalDataViewController.rawValue, for: indexPath) as? PersonalDataTableViewCell else {
            return UITableViewCell()
        }
        cell.configureUI(with: model)
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = interactor.models[indexPath.section].options[indexPath.row]
        
        model.key
        
        guard let vc = getViewController(storyboardId: StoryBoards.Inactive.rawValue, viewControllerId: ViewControllers.InactiveViewController.rawValue) as? InactiveViewController else { return }
        vc.setState(.showEnterPersonalDataView(model.title))
                vc.delegate = self
                self.present(vc, animated: false)

    }
    
}

extension PersonalDataViewController: PersonalDataViewProtocol {}
extension PersonalDataViewController: InactiveViewControllerDelegate {
    
    func approveDataButtonTapped(_ text: String) {
        
//        let regResource = Resource<ProfileResponseData>(path: RegistrationRequestPaths.registration.rawValue,
//                                                                 requestType: .POST,
//                                                                 requestData: [RegistrationRequestKeys.phone.rawValue: phoneNumber])
//
//            NetworkService.shared.makeRequest(for: regResource, completion: {[unowned self] result in
//
//                switch result {
//
//                case .success(let response):
//                    self.regResponse = response
//                    print("RESPONSE CODE: \(self.regResponse.data.code)")
//                    self.scheduleNotification(with: self.regResponse.data.code)
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//
//            })
        }
        
    
    
}
