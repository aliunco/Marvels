//
//  CharactersLodingFooterView.swift
//  MarvelsApp
//
//  Created by aliunco on 3/12/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

class CharactersLodingFooterView: UICollectionReusableView, NibLoader {
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        return self.loadFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
