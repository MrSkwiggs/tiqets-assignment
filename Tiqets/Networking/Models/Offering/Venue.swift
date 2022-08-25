//
//  Venue.swift
//  Networking
//
//  Created by Dorian Grolaux on 25/08/2022.
//

import Foundation

public class Venue: Offering {
    let rating: Float
    
    enum CodingKeys: String, CodingKey {
        case rating = "stars_rating"
    }
}

