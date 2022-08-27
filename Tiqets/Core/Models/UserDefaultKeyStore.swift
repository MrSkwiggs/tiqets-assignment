//
//  UserDefaultKeyStore.swift
//  Core
//
//  Created by Dorian Grolaux on 27/08/2022.
//

import Foundation

/// A KeyStore that relies on Foundation's `UserDefaults` for storage persistence.
public protocol UserDefaultKeyStore: KeyStore where Storage == UserDefaults, Key.RawValue == String {
    /// The store's suite identifier
    static var suitePrefix: String { get }
}

// MARK: - Default conformance

public extension UserDefaultKeyStore {
    
    /// Returns the Bundle identifier
    static var appPrefix: String {
        Bundle(for: Self.self).bundleIdentifier!
    }
    
    static var storage: Storage { .init(suiteName: suitePrefix)! }
    
    func get<Item: Codable>(_ type: Item.Type = Item.self, for key: Key) -> Item? {
        guard let data = data(for: key) else {
            return nil
        }
        
        return try? JSONDecoder().decode(Container<Item>.self, from: data).data
    }
    
    func set<Item: Codable>(_ value: Item, for key: Key) {
        if let optional = value as? AnyOptional, optional.isNil {
            return deleteValue(for: key)
        }
        
        Self.storage.set(try? JSONEncoder().encode(Container(data: value)), forKey: key.rawValue)
    }
    
    func deleteValue(for key: Key) {
        Self.storage.set(nil, forKey: key.rawValue)
    }
    
    func data(for key: Key) -> Data? {
        Self.storage.data(forKey: key.rawValue)
    }
    
    func clear() {
        Self.storage.removeSuite(named: Self.suitePrefix)
    }
}

/**
 Wrapper for handling encoding of primitive types. (Primitive types cannot be encoded as a top-level object directly)
 */
fileprivate struct Container<T: Codable>: Codable {
    let data: T
}
