//
//  Offerings.swift
//  Networking
//
//  Created by Dorian Grolaux on 25/08/2022.
//

import Foundation
import Netswift

public extension TiqetsAPI {
    enum Offerings: NetswiftRequestPerformable {
        case getAll
    }
}

extension TiqetsAPI.Offerings: TiqetsRoute {
    public var host: String? { nil }
    
    public var path: String? {
        switch self {
        case .getAll:
            #if DEBUG
            return "offerings.json"
            #else
            return "path/to/api"
            #endif
        }
    }
    
    #if DEBUG
    public var url: URL {
        switch self {
        case .getAll:
            return .init(fileReferenceLiteralResourceName: "offerings.json")
        }
    }
    #endif
}

extension TiqetsAPI.Offerings: TiqetsRequest {
    public struct Response: Codable {
        public let venues: [Venue]
        public let exhibitions: [Exhibition]
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: IntermediateContainerCodingKeys.self)
            var arrayContainer = try container.nestedUnkeyedContainer(forKey: .items)
            
            var venues: [Venue] = []
            var exhibitions: [Exhibition] = []
            
            while !arrayContainer.isAtEnd {
                
                do {
                    venues.append(try arrayContainer.decode(Venue.self))
                } catch {
                    exhibitions.append(try arrayContainer.decode(Exhibition.self))
                }
            }
            
            self.venues = venues
            self.exhibitions = exhibitions
        }
    }
}

fileprivate extension TiqetsAPI.Offerings {
    enum IntermediateContainerCodingKeys: String, CodingKey {
        case items = "items"
    }
    
    enum SubType: String, Codable {
        case venue = "VENUE"
        case exhibition = "EXHIBITION"
        
        enum CodingKeys: String, CodingKey {
            case type
        }
    }
}

// MARK: - Decoding

//public extension TiqetsAPI.Offerings.Offering {
//    required init(from decoder: Decoder) throws {
//        let container = decoder.container(keyedBy: <#T##CodingKey.Protocol#>)
//    }
//}
//
//private extension TiqetsAPI.Offerings.Offering {
//    enum CodingKeys: String, CodingKey {
//        case type
//        case id = "id"
//    }
//}
