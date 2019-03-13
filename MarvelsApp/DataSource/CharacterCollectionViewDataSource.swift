//
//  CharacterCollectionViewDataSource.swift
//  MarvelsApp
//
//  Created by aliunco on 3/12/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

extension CharactersDatasource: UICollectionViewDataSource {
    
    func register(collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.register(
            CharacterCollectionViewCell.loadNib(),
            forCellWithReuseIdentifier: CharacterCollectionViewCell.nibName
        )
        collectionView.register(
            CharactersLodingFooterView.nibView,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "FooterView"
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterView", for: indexPath)
        return footerView
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.nibName, for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell () }
        cell.character = items[indexPath.row]
        
        return cell
    }
    
}
