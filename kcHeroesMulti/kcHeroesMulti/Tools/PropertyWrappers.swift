//
//  PropertyWrappers.swift
//  kcHeroesMulti
//
//  Created by Aitor Iglesias Pubill on 7/12/22.
//

import Foundation

@propertyWrapper
class kcPersistenceKeyChain {
    private var key: String
    
    init(key: String) {
        self.key = key
    }
    
    var wrappedValue: String {
        set {
            saveKC(key: key, value: newValue)
        }
        
        get {
            if let value = loadKC(key: key) {
                return value
            } else {
                return ""
            }
        }
    }
}
