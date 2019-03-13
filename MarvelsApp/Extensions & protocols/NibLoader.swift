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
    static var nibName: String { get }
}

extension NibLoader where Self: NameDescribable  {
    static var nibName: String {
        return self.typeName.components(separatedBy: ".")[0]
    }
}

extension NibLoader where Self: UIView {
    
    static var nibView: UINib? {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    internal static func viewFromNib() -> Self? {
        let view = nibView?.instantiate(withOwner: nil, options: nil)[0]
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

extension NibLoader where Self: UICollectionViewCell {
    
    static func loadNib() -> UINib? {
        return UINib(nibName: nibName, bundle: nil)
    }
}

extension NibLoader where Self: UIViewController {
    
    internal static func viewFromNib() -> Self? {
        let view = UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0]
        return view as? Self
    }
    
    static func loadFromNib() -> Self? {
        return Self(nibName: nibName, bundle: nil)
    }
    
}
