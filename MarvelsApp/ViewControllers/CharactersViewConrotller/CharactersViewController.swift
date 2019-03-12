//
//  CharactersViewController.swift
//  MarvelsApp
//
//  Created by aliunco on 3/12/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit


class CharactersViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource = CharactersDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.register(collectionView: collectionView)
        dataSource.delegate = self
        dataSource.getMoreItems()
    }

}


extension CharactersViewController: CharactersDatasourceDelegate {
    func listHasBeenUpdated() {
        collectionView.reloadData()
    }
}
