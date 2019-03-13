//
//  CharacterInfoResourceListTableViewCell.swift
//  MarvelsApp
//
//  Created by aliunco on 3/13/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

class CharacterInfoResourceListTableViewCell: BaseTableViewCell, UICollectionViewDataSource {

    @IBOutlet weak private var collectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var resourseListTitleLabel: UILabel!
    
    var title: String? {
        didSet {
            resourseListTitleLabel.text = title
        }
    }
    
    var items: [SimplePresentable] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        collectionView.register(CharacterInfoResouseListItemCollectionViewCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        collectionView.dataSource = self
        let height = (collectionView.collectionViewLayout as? CarouselCollectionFlowLayout)?.itemHeight()
        collectionHeightConstraint.constant = height ?? 0
    }
    
    
    //collectionview datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(CharacterInfoResouseListItemCollectionViewCell.self, for: indexPath)
        if items.count > indexPath.row,
            let title = items[indexPath.row].title
        {
            cell.update(with: items[indexPath.row].thumbnail?.getUrl(), title: title)
        }
        return cell
    }
    
}
