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
    
    public var path: String? { nil }
    
    public var url: URL {
        switch self {
        case .getAll:
            return .init(fileReferenceLiteralResourceName: "offerings.json")
        }
    }
}

extension TiqetsAPI.Offerings: TiqetsRequest {
    public typealias Response = [Offering]
}

fileprivate extension TiqetsAPI.Offerings {
    private struct IntermediateResponse: Codable {
        let items: [SubType]
        
        enum CodingKeys: String, CodingKey {
            case items = "items"
        }
    }
    
    enum SubType: String, Codable {
        case venue = "VENUE"
        case exhibition = "EXHIBITION"
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
