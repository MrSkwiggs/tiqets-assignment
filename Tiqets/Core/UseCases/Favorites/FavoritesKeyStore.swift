//
//  FavoritesKeyStore.swift
//  Core
//
//  Created by Dorian Grolaux on 27/08/2022.
//

import Foundation

class FavoritesKeyStore: UserDefaultKeyStore {
    enum Key: String {
        case favoritesIDs = "favoritesIDs"
    }
    
    static var suitePrefix: String {
        "\(appPrefix).favorites"
    }
}
