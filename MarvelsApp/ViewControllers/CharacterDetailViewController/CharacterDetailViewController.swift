//
//  CharacterDetailViewController.swift
//  MarvelsApp
//
//  Created by aliunco on 3/13/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

class CharacterDetailViewController: BaseViewController {
    
    @IBOutlet weak private var favCharacterWrapperView: UIView!
    @IBOutlet weak private var favCharacterImageView: UIImageView!
    @IBOutlet weak private var addToFavButton: UIButton!
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
        
        if let favCharacterID = Character.shared?.id, favCharacterID == Int(characterID) {
            addToFavButton.isHidden = true
        }
        
        if let id = Character.shared?.id, id != Int(characterID), let image = Character.shared?.thumbnail?.getUrl() {
            favCharacterWrapperView.isHidden = false
            favCharacterImageView.il.setImage(url: image, placeholer: #imageLiteral(resourceName: "placeholder"))
            favCharacterWrapperView.layer.cornerRadius = 50
            favCharacterWrapperView.clipsToBounds = true
        } else {
            favCharacterWrapperView.isHidden = true
        }
        
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        guard let character = dataSource.character else { return }
        addToFavButton.isHidden = true
        character.write() //save as favorite character
    }
    
    @IBAction func favCharacterButtonTapped(_ sender: Any) {
        
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
