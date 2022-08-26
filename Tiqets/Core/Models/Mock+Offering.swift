//
//  Mock+Offering.swift
//  Core
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import Networking

public extension Mock {
    enum Offerings {
        public enum Venues {
            public static let vanGogh: Venue = .init(id: "1",
                                              name: "Van Gogh Museum",
                                              imageURL: .init(string: "https://aws-tiqets-cdn.imgix.net/images/content/9d3735fc2e334bc3a3b68822a2e801b4.jpg?w=315&h=210&dpr=2&q=40&fit=crop")!,
                                              currency: "EUR",
                                              price: "10,-",
                                              rating: 3.4)
            public static let moco: Venue =  .init(id: "2",
                                            name: "Moco Museum",
                                            imageURL: .init(string: "https://aws-tiqets-cdn.imgix.net/images/content/7fc58eaa938444d3963660eed00b3ce0.jpg?auto=format&dpr=2&fit=crop&h=200&ixlib=python-3.2.1&q=25&w=300&s=6efcc07eb8bdd167894165e382662eb4")!,
                                            currency: "EUR",
                                            price: "5.50",
                                            rating: 4.8)
        }
        
        public enum Exhibitions {
            public static let erraticGrowth: Exhibition = .init(id: "3",
                                                         name: "Erratic Growth",
                                                         imageURL: .init(string: "https://aws-tiqets-cdn.imgix.net/images/content/770f93d18e1544728550c132f46b3f86.jpg?auto=format&fit=crop&h=275&ixlib=python-3.2.1&q=70&w=275&s=137d1f6c19d580c9958508b0ca26384e")!,
                                                         currency: "EUR",
                                                         price: "9.90",
                                                         location: "Amsterdam",
                                                         startDate: .now,
                                                         endDate: .now.addingTimeInterval(TimeInterval(60 * 60 * 24)))
        }
    }
}
