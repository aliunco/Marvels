//
//  CharacterCollectionViewCell.swift
//  MarvelsApp
//
//  Created by aliunco on 3/12/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: BaseCollectionViewCell {
    
    static let SlidingCellFeatureHeight: CGFloat = 280
    static let SlidingCellCollapsedHeight: CGFloat = 100

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageCoverView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    private var downloadingImageTask: URLSessionDataTask?
    
    var character: Character? {
        didSet {
            downloadingImageTask?.cancel()
            if let marvelCharacter = character {
                // Setting a remote image
                if let url = marvelCharacter.thumbnail?.getUrl() {
                    self.downloadingImageTask = imageView.il.setImage(url: url, placeholer: UIImage(named: "placeholder")!)
                }
                titleLabel.text = marvelCharacter.name
            }
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let featuredHeight = CharacterCollectionViewCell.SlidingCellFeatureHeight
        let standardHeight = CharacterCollectionViewCell.SlidingCellCollapsedHeight
        
        let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))
        
        let minAlpha: CGFloat = 0.3
        let maxAlpha: CGFloat = 0.75
        
        imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(delta, 0.5)
        titleLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
    }

}
