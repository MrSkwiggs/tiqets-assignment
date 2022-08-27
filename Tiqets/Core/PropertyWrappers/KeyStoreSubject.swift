//
//  KeyStoreSubject.swift
//  Core
//
//  Created by Dorian Grolaux on 27/08/2022.
//

import Foundation
import Combine

/**
 A wrapper for properties which can be observed, and for which new values are automatically persisted to the given key store.
 */
@propertyWrapper
public struct KeyStoreSubject<Item: Codable, KeyStore: Core.KeyStore> {
    
    public let subject: CurrentValueSubject<Item, Never>
    
    private let keyStore: KeyStore
    private let key: KeyStore.Key
    
    public var wrappedValue: Item {
        get { subject.value }
        set {
            keyStore.set(newValue, for: key)
            subject.send(newValue)
        }
    }
    
    public var projectedValue: Self { self }
    
    public init(keyStore: KeyStore, key: KeyStore.Key, default: Item) {
        self.keyStore = keyStore
        self.key = key
        self.subject = .init(keyStore.get(Item.self, for: key) ?? `default`)
    }
}

public extension KeyStoreSubject where Item: ExpressibleByNilLiteral {
    init(keyStore: KeyStore, key: KeyStore.Key) {
        self.init(keyStore: keyStore, key: key, default: nil)
    }
}
