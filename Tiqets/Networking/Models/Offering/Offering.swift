//
//  Offering.swift
//  Networking
//
//  Created by Dorian Grolaux on 25/08/2022.
//

import Foundation

public protocol Offering: Codable, Identifiable, Equatable {
    var id: String { get }
    var name: String { get }
    var imageURL: URL { get }
    var currency: String { get }
    var price: String { get }
}

internal enum OfferingCodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case imageURL = "image"
    case currency = "price_currency_code"
    case price = "price"
}

