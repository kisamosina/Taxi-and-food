//
//  MenuView.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

protocol MenuViewDelegate: AnyObject {
    func performSegue(_ type: MapViewControllerSegue)
}

class MenuView: UIView {
    
    weak var delegate: MenuViewDelegate?
    var menuItems: [MapMenuSection]!
    
    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var aboutLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = Colors.mapMenuColor.getColor()
        self.layer.cornerRadius = MapMenuViewUIData.cornerRadius.rawValue
        self.layer.shadowColor = Colors.shadowColor.getColor().cgColor
        self.layer.shadowOpacity = Float(MapMenuViewUIData.shadowOpacity.rawValue)
        self.layer.shadowRadius = MapMenuViewUIData.cornerRadius.rawValue
        self.layer.shadowOffset = CGSize(width: MapMenuViewUIData.shadowOffsetWidth.rawValue,
                                         height: MapMenuViewUIData.shadowOffsetWidth.rawValue)
        self.layer.masksToBounds = false
        
    }
    
    func setupView(with menuItems: [MapMenuSection]) {
        self.menuLabel.text = MapMenuViewTexts.menuLabelText
        self.aboutLabel.text = MapMenuViewTexts.aboutLabelText
        self.aboutLabel.textColor = Colors.fontGrey.getColor()
        self.menuItems = menuItems
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.menuTableView.tableFooterView = UIView()
    }
    
    func reloadView(with menuItems: [MapMenuSection]) {
        self.menuLabel.text = MapMenuViewTexts.menuLabelText
        self.aboutLabel.text = MapMenuViewTexts.aboutLabelText
        self.aboutLabel.textColor = Colors.fontGrey.getColor()
        self.menuItems = menuItems
        self.menuTableView.reloadData()
    }
    
}

extension MenuView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MapMenuViewTexts.menuTableViewCellId, for: indexPath) as? MapMenuViewCell
        else { return UITableViewCell() }
        let item = menuItems[indexPath.section].items[indexPath.row]
        cell.setupCell(with: item.itemImage, and: item.itemName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = menuItems[indexPath.section].items[indexPath.row]
        let segueType  = MapViewControllerSegue.getMapViewControllerSegue(item.itemName)
        self.delegate?.performSegue(segueType)
        
        
    }

}
