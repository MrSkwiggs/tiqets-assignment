//
//  Exhibition.swift
//  Networking
//
//  Created by Dorian Grolaux on 25/08/2022.
//

import Foundation

public struct Exhibition: Offering {
    public let id: String
    public let name: String
    public let imageURL: URL
    public let currency: String
    public let price: String
    public let location: String
    public let startDate: Date
    public let endDate: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case imageURL = "image"
        case currency = "price_currency_code"
        case price = "price"
        case location = "location"
        case startDate = "start_date"
        case endDate = "end_date"
    }
}
