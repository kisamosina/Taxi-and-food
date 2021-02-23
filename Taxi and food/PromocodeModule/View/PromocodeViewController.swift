//
//  PromocodeViewController.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 23.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class PromocodeViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = PromocodeViewControllerTexts.vcTitle
        self.view.backgroundColor = Colors.mapMenuColor.getColor()
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension PromocodeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PromocodeViewControllerTexts.promocodeOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PromocodeViewControllerTexts.promocodeChooseCellId, for: indexPath)
        cell.textLabel?.text = PromocodeViewControllerTexts.promocodeOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueCase = PromocodeViewControllerTexts.getSegue(PromocodeViewControllerTexts.promocodeOptions[indexPath.row])
        
        switch segueCase {
                
        case .enterPromocode:
            let storyboard = UIStoryboard(name: StoryBoards.Promocode.rawValue, bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: ViewControllers.PromocodeEnterViewController.rawValue)
            self.navigationController?.pushViewController(vc, animated: true)
        case .showHistory:
            break
        case .unknown:
            break
        }
    }
    
}
