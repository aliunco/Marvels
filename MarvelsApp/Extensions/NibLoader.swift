//
//  NibLoader.swift
//  MarvelsApp
//
//  Created by aliunco on 3/11/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoader {
    static func viewFromNib() -> Self?
    func loadFromNib() -> Self?
}

extension NibLoader where Self: UIView {
    
    internal static func viewFromNib() -> Self? {
        let name = self.typeName.components(separatedBy: ".")[0]
        let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)[0]
        return view as? Self
    }
    
    func loadFromNib() -> Self? {
        let isJustAPlaceholder = subviews.count == 0
        if isJustAPlaceholder {
            let theRealThing = type(of: self).viewFromNib()
            theRealThing?.frame = bounds
            translatesAutoresizingMaskIntoConstraints = false
            theRealThing?.translatesAutoresizingMaskIntoConstraints = false
            return theRealThing
        }
        return self
    }
    
}

extension UIView: NibLoader {}
