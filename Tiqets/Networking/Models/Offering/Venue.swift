//
//  Venue.swift
//  Networking
//
//  Created by Dorian Grolaux on 25/08/2022.
//

import Foundation

public struct Venue: Offering {
    public let id: String
    public let name: String
    public let imageURL: URL
    public let currency: String
    public let price: String
    public let rating: Float
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case imageURL = "image"
        case currency = "price_currency_code"
        case price = "price"
        case rating = "stars_rating"
    }
    
    public init(id: String, name: String, imageURL: URL, currency: String, price: String, rating: Float) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.currency = currency
        self.price = price
        self.rating = rating
    }
}

