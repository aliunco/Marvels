//
//  NameDescribable.swift
//  MarvelsApp
//
//  Created by aliunco on 3/11/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import Foundation

protocol NameDescribable {
    var typeName: String { get }
    static var typeName: String { get }
}

extension NameDescribable {
    var typeName: String {
        return String(describing: type(of: self)).components(separatedBy: ".")[0]
    }
    
    static var typeName: String {
        return String(describing: self).components(separatedBy: ".")[0]
    }
}

extension NSObject: NameDescribable {}
extension Array: NameDescribable {} 
