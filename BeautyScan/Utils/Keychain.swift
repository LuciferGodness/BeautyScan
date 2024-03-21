//
//  Keychain.swift
//  BeautyScan
//
//  Created by Admin on 3/21/24.
//

import Foundation
import Security

enum KeychainKey: String {
    case authToken
}

@propertyWrapper
struct KeychainToken {
    let key: KeychainKey
    let defaultValue: String?
    
    init(key: KeychainKey, defaultValue: String? = nil) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: String? {
        get {
            return loadToken()
        }
        set {
            if let value = newValue {
                saveToken(value)
            } else {
                deleteToken()
            }
        }
    }
    
    private func saveToken(_ token: String) {
        guard let data = token.data(using: .utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    private func loadToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecReturnAttributes as String: kCFBooleanTrue!
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
            let existingItem = item as? [String: Any],
            let tokenData = existingItem[kSecValueData as String] as? Data,
            let token = String(data: tokenData, encoding: .utf8) else {
                return defaultValue
        }
        
        return token
    }
    
    private func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
