//
//  KeyStore.swift
//  Core
//
//  Created by Dorian Grolaux on 27/08/2022.
//

import Foundation

/// A Keystore offers a key-based value persistence source of data.
public protocol KeyStore: AnyObject {
    /// The container in which this KeyStore's values are stored.
    associatedtype Storage
    
    /// A type used to identify and distinguish stored values by this store.
    associatedtype Key: RawRepresentable
    
    /// An instance of the storage container
    static var storage: Storage { get }
    
    /**
     Retrieves the associated value identified by the given key.
     - parameters:
     - type: The expected type of value to be returned.
     - key: The key used to identify the stored value.
     - returns: If a value already exists in the store, returns that value. Returns `nil` otherwise.
     */
    func get<Item: Codable>(_ type: Item.Type, for key: Key) -> Item?
    
    /**
     Stores the given value identified by the given key.
     - parameters:
     - value: The value to store.
     - key: The key to identify this value by.
     */
    func set<Item: Codable>(_ value: Item, for key: Key)
    
    /**
     Deletes all stored values.
     */
    func clear()
}
