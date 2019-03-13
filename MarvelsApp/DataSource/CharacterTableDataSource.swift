//
//  CharacterTableDataSource.swift
//  MarvelsApp
//
//  Created by aliunco on 3/13/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

extension CharacterDataSource: UITableViewDataSource {
    
    func registerCells(tableView: UITableView) {
        tableView.register(HeroBasicInfoTableViewCell.self)
        tableView.register(CharacterInfoResourceListTableViewCell.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataSource.count > indexPath.row {
            switch dataSource[indexPath.row] {
            case .basicInfo(let name, let description):
                let cell = tableView.dequeue(HeroBasicInfoTableViewCell.self, for: indexPath)
                cell.update(name: name, description: description)
                return cell
            case .series(let title, let items),
                 .events(let title, let items),
                 .stories(let title, let items),
                 .comics(let title, let items):
                let cell = tableView.dequeue(CharacterInfoResourceListTableViewCell.self, for: indexPath)
                cell.title = title
                cell.items = items
                return cell
            }
        }
        
        //unexpected state
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
}
