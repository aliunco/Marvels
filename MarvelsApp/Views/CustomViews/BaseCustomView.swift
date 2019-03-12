//
//  BaseCustomView.swift
//  MarvelsApp
//
//  Created by aliunco on 3/12/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

class BaseCustomView: UIView, NibLoader {
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        return self.loadFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    internal func setup() {}
}
