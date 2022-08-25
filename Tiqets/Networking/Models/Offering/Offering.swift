//
//  Offering.swift
//  Networking
//
//  Created by Dorian Grolaux on 25/08/2022.
//

import Foundation

public class Offering: Codable, Identifiable, Equatable {
    public let id: String
    public let name: String
    public let imageURL: URL
    public let currency: String
    public let price: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case imageURL = "image"
        case currency = "price_currency_code"
        case price = "price"
    }
}

