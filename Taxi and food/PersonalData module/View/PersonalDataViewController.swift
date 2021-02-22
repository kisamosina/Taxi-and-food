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
    
    @IBOutlet var policyLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var interactor: PersonalDataInteractorProtocol!
    var models: [PersonalDataSection]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPolicyLabelGestureRecognizer()
        
        self.interactor = PersonalDataInteractor(view: self)
        self.interactor.configure()
        //FIXME: Для имен ячеек лучше использовать enum
        tableView.register(PersonalDataCell.self, forCellReuseIdentifier: "personalData")

        confugureLabel()
        
    }
    
    //MARK: - Methods

    func confugureLabel() {
        policyLabel.text = PersonalDataViewControllerText.policyLabelText
        
        //MARK: - Даш, ты не добавила эту строку
        policyLabel.setAttributedText(PersonalDataViewControllerText.userArgeement)
    }
    
    private func addPolicyLabelGestureRecognizer() {
        policyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapPolicyLabel(gesture:))))
    }
    
    @objc func tapPolicyLabel(gesture: UITapGestureRecognizer) {
        guard let text = policyLabel.text else { return }
        
        let range = (text as NSString).range(of: PersonalDataViewControllerText.userArgeement)
        
        if gesture.didTapAttributedTextInLabel(label: policyLabel, inRange: range) {
            
            //TODO: Даш в папке Data для имен сторибордов есть отдельный enum, испопльзуй его
            
            guard let uaVC = storyboard?.instantiateViewController(identifier: "userAgreement")
            else { return }
            self.present(uaVC, animated: true, completion: nil)
            
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
            
        return cell
    }
    
    
}

extension PersonalDataViewController: PersonalDataViewProtocol {}
