//
//  PersistHero.swift
//  MarvelsApp
//
//  Created by aliunco on 3/11/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import Foundation

extension Character: DefaultStorable {
    
    static private var localValue: Character?
    static private var hasLocalValue: Bool = {
        Character.localValue = Character.localValue ?? Character.read(forKey: Character.defaultIdentifier)
        return Character.localValue != nil
    }()
    
    static var shared: Character? {
        get {
            if !Character.hasLocalValue { return nil }
            Character.localValue = Character.localValue ?? Character.read(forKey: Character.defaultIdentifier)
            return Character.localValue
        }
    }
    
    static func clear() {
        Character.hasLocalValue = false
        Character.localValue = nil
        UserDefaults.standard.removeObject(forKey: self.defaultIdentifier)
    }
    
    func write() {
        Character.hasLocalValue = true
        Character.localValue = self
        UserDefaults.standard.df.store(self, forKey: Character.defaultIdentifier)
    }
}
