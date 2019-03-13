//
//  UICollectionView.swift
//  MarvelsApp
//
//  Created by aliunco on 3/13/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        register(
            UINib(nibName: T.typeName, bundle: nil),
            forCellWithReuseIdentifier: reuseIdentifier ?? T.typeName
        )
    }
    
    func dequeue<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.typeName, for: indexPath) as? T else {
            fatalError("Could not deque cell with type \(T.self)")
        }
        return cell
    }
    
    func dequeueCell(reuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
    
}
