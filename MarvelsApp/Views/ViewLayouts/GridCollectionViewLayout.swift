//
//  GridCollectionViewLayout.swift
//  MarvelsApp
//
//  Created by aliunco on 3/13/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

class GridCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    private var cellSpacing: CGFloat = 8
    private let imageRatio: CGFloat = 1.25
    private let numberOfColumns: CGFloat = 2
    private let otherContentOfCellHeight: CGFloat = 128
    private let righLeftImagePadding: CGFloat = 10 * 2
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    override var itemSize: CGSize {
        set {}
        get {
            return CGSize(width: itemWidth(), height: itemHeight())
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView?.contentOffset ?? .zero
    }
    
    func setupLayout() {
        minimumInteritemSpacing = cellSpacing / 2
        minimumLineSpacing = cellSpacing
        scrollDirection = .vertical
    }
    
    func itemWidth() -> CGFloat {
        return (self.collectionView!.frame.width - (numberOfColumns - 1) * cellSpacing) / numberOfColumns
    }
    
    func itemHeight() -> CGFloat {
        let imageWidth = itemWidth() - righLeftImagePadding
        return imageWidth * imageRatio + otherContentOfCellHeight
    }
}
