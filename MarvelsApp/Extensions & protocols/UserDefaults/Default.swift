//
//  Default.swift
//  Gahvare
//
//  Created by aliunco on 3/11/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import Foundation

public final class Default<Base> {
    let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol DefaultCompatible {}
public extension DefaultCompatible {
    public var df: Default<Self> {
        return Default(self)
    }
}

extension UserDefaults: DefaultCompatible {}
