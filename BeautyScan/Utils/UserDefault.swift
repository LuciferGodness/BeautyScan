//
//  UserDefaults.swift
//  BeautyScan
//
//  Created by admin on 17.02.2024.
//

import Foundation


enum UserDefaultsKey: String {
    case skinType
    case rightEyelid
    case leftEyelid
    case acne
    case blackhead
}

@propertyWrapper
final class UserDefault<T> {
    let key: String
    let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
