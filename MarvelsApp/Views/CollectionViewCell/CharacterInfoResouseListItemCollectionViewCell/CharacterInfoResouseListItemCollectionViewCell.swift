//
//  CharacterInfoResouseListItemCollectionViewCell.swift
//  MarvelsApp
//
//  Created by aliunco on 3/13/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

class CharacterInfoResouseListItemCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak private var contentWrapperView: UIView!
    @IBOutlet private weak var resourceLabel: UILabel!
    @IBOutlet private weak var resourceImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentWrapperView.layer.cornerRadius = 4
        contentWrapperView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
    }
    
    func update(with imageUrl: URL?, title: String) {
        resourceLabel.text = title
        if let url = imageUrl {
            resourceImageView.il.setImage(url: url, placeholer: #imageLiteral(resourceName: "placeholder"))
        } else {
            resourceImageView.image = #imageLiteral(resourceName: "placeholder")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resourceImageView.image = nil
    }
    
}
