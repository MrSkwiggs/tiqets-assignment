//
//  Exhibition.swift
//  Networking
//
//  Created by Dorian Grolaux on 25/08/2022.
//

import Foundation

public class Exhibition: Offering {
    let location: String
    let startDate: Date
    let endDate: Date
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
        case startDate = "start_date"
        case endDate = "end_date"
    }
}
