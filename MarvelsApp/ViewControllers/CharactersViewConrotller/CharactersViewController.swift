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
        self.title = "Heros"
        
        dataSource.register(collectionView: collectionView)
        dataSource.delegate = self
        dataSource.getMoreItems()
        collectionView.collectionViewLayout = GridCollectionViewFlowLayout()
        collectionView.delegate = self
    }
}


extension CharactersViewController: CharactersDatasourceDelegate {
    func listHasBeenUpdated(newItems: [Character]) {
        
        if collectionView.visibleCells.count < dataSource.items.count {
            collectionView.reloadData()
            return
        }
        
        var newIndexPathes = [IndexPath]()
        for index in 0...newItems.count - 1 {
            let newIndex = collectionView.visibleCells.count + index
            newIndexPathes.append(IndexPath(item: newIndex, section: 0))
        }
    
        collectionView.performBatchUpdates({
            self.collectionView.insertItems(at: newIndexPathes)
        }, completion: nil)
        
    }
    
    func startLoading() {
        collectionView.reloadData()
    }
}

extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == dataSource.items.count - 2  {
            dataSource.getMoreItems()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return dataSource.isInProgress ? CGSize(width: collectionView.frame.width, height: 50) : .zero
    }
    
}
