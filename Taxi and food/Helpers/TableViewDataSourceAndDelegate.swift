//
//  MapTableViewDataSorceAndDelegate.swift
//  Taxi and food
//
//  Created by Maxim Alekseev on 20.02.2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit

class TableViewDataSource<CellType, ViewModel>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
    
    typealias CellConfigurator = (CellType, ViewModel) -> Void
    
    private let cellIdentifier: String
    private var items: [ViewModel]
    private let cellConfigurator: CellConfigurator
    
    init(cellIdentifier: String, items: [ViewModel], cellConfigurator: @escaping CellConfigurator) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.cellConfigurator = cellConfigurator
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CellType else {
            fatalError("cell with \(cellIdentifier) and \(CellType.self) does not exist")
        }
        let cellVM = items[indexPath.row]
        cellConfigurator(cell, cellVM)
        return cell
    }
    
    func updateItems(_ items: [ViewModel]) {
        self.items = items
    }
}
