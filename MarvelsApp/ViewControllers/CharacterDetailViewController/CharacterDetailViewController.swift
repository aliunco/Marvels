//
//  CharacterDetailViewController.swift
//  MarvelsApp
//
//  Created by aliunco on 3/13/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

class CharacterDetailViewController: BaseViewController {
    
    @IBOutlet weak private var characterImageView: UIImageView!
    @IBOutlet weak private var tableView: UITableView!
    var characterID: String!
    var dataSource = CharacterDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()    
        tableView.dataSource = dataSource
        dataSource.delegate = self
        dataSource.registerCells(tableView: tableView)
        dataSource.loadData(with: characterID)
    }
}

extension CharacterDetailViewController: CharacterDataSourceDelegate {
    func resourceUpdated() {
        if let thumbNail = self.dataSource.character?.thumbnail?.getUrl() {
            characterImageView.il.setImage(url: thumbNail, placeholer: #imageLiteral(resourceName: "placeholder"))
        }
        self.tableView.reloadData()
    }
}
