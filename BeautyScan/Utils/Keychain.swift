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

enum KeychainError: Error {
    case creatingError
    case operationError
}

protocol DataTransformable {
    var data: Data { get }
    
    static func instantiateFrom(data: Data) -> Self
}

@propertyWrapper
struct Keychain<T> where T: DataTransformable {
    let key: KeychainKey
    
    init(key: KeychainKey) {
        self.key = key
    }
    
    var wrappedValue: T? {
        get {
            guard let data = try? KeychainWrapper.get(account: key.rawValue) else { return nil }
            return T.instantiateFrom(data: data)
        }
        set {
            guard let value = newValue else {
                try? KeychainWrapper.delete(account: key.rawValue)
                return
            }
            try? KeychainWrapper.set(value: value.data, account: key.rawValue)
        }
    }
}

final class KeychainWrapper: NSObject {
    static func set(value: Data, account: String) throws {
        if try KeychainOperations.exists(account: account) {
            try KeychainOperations.update(value: value, account: account)
        } else {
            try KeychainOperations.add(value: value, account: account)
        }
    }
    
    static func get(account: String) throws -> Data? {
        if try KeychainOperations.exists(account: account) {
            return try KeychainOperations.retreive(account: account)
        } else {
            throw KeychainError.operationError
        }
    }
    
    static func getString(account: String) throws -> String? {
        guard let data = try get(account: account) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    static func setString(_ value: String, account: String) throws {
        guard let data = value.data(using: .utf8) else { return }
        try set(value: data, account: account)
    }

    static func delete(account: String) throws {
        if try KeychainOperations.exists(account: account) {
            return try KeychainOperations.delete(account: account)
        } else {
            throw KeychainError.operationError
        }
    }
    
    static func deleteAll() throws {
        try KeychainOperations.deleteAll()
    }
}

fileprivate final class KeychainOperations: NSObject {
    static func add(value: Data, account: String) throws {
        let status = SecItemAdd([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: value] as NSDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.operationError }
    }
    
    static func update(value: Data, account: String) throws {
        let status = SecItemUpdate([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account] as NSDictionary, [
                kSecValueData: value] as NSDictionary)
        guard status == errSecSuccess else { throw KeychainError.operationError }
    }
    
    static func retreive(account: String) throws -> Data? {
        var result: AnyObject?
        let status = SecItemCopyMatching([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecReturnData: true] as NSDictionary, &result)
        switch status {
        case errSecSuccess:
            return result as? Data
        case errSecItemNotFound:
            return nil
        default:
            throw KeychainError.operationError
        }
    }

    static func delete(account: String) throws {
        let status = SecItemDelete([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account] as NSDictionary)
        guard status == errSecSuccess else { throw KeychainError.operationError }
    }

    static func deleteAll() throws {
        let status = SecItemDelete([
            kSecClass: kSecClassGenericPassword] as NSDictionary)
        guard status == errSecSuccess else { throw KeychainError.operationError }
    }

    static func exists(account: String) throws -> Bool {
        let status = SecItemCopyMatching([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecReturnData: false] as NSDictionary, nil)
        switch status {
        case errSecSuccess:
            return true
        case errSecItemNotFound:
            return false
        default:
            throw KeychainError.creatingError
        }
    }
}

//TODO: REMOVE
extension String: DataTransformable {
    var data: Data {
        self.data(using: .utf8) ?? Data()
    }
    
    static func instantiateFrom(data: Data) -> String {
        String(data: data, encoding: .utf8) ?? ""
    }
}
