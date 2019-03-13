//
//  CarouselCollectionFlowLayout.swift
//  MarvelsApp
//
//  Created by aliunco on 3/13/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

class CarouselCollectionFlowLayout: UICollectionViewFlowLayout {
    
    private var cellSpacing: CGFloat = 8
    private static let smallWindowSize: CGFloat = 520
    private static let mediumWindowSize: CGFloat = 767
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 0
        minimumLineSpacing = cellSpacing
        scrollDirection = .horizontal
    }
    
    func itemWidth() -> CGFloat {
        return CarouselCollectionFlowLayout.itemWidth(relateTo: self.collectionView?.frame.width ?? 0, cellSpacing: cellSpacing)
    }
    
    func itemHeight() -> CGFloat {
        return itemWidth() * 1.5
    }
    
    class func itemWidth(relateTo parentWidth: CGFloat, cellSpacing: CGFloat) -> CGFloat {
        let collectionWidth = parentWidth
        if collectionWidth < smallWindowSize {
            return round((collectionWidth - (3 * cellSpacing)) / 2.25)
        } else if collectionWidth > smallWindowSize && collectionWidth < mediumWindowSize {
            return round((collectionWidth - (4 * cellSpacing)) / 3.5)
        } else {
            return round((collectionWidth - (5 * cellSpacing)) / 4.5)
        }
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
}

