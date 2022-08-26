//
//  OfferingProviderUseCase.swift
//  Core
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import Networking
import Combine
import Netswift

public protocol OfferingProviderUseCase {
    
    typealias Offering = TiqetsAPI.Offerings.Response
    
    var offeringsPublisher: NetswiftResponsePublisher<Offering> { get }
}

public class OfferingProvider: OfferingProviderUseCase {
    
    public typealias Offering = TiqetsAPI.Offerings.Response
    
    private var offeringsSubject: NetswiftResponseSubject<Offering> = .init(.initial)
    
    public lazy var offeringsPublisher: NetswiftResponsePublisher<Offering> = {
        refresh()
        return offeringsSubject.eraseToAnyPublisher()
    }()
    
    init() {}
    
    private func refresh() {
        offeringsSubject.send(.loading)
        
        TiqetsAPI.Offerings.getAll.perform { [weak self] response in
            guard let self = self else { return }
            self.offeringsSubject.send(State(from: response))
        }
    }
}

public extension Mock {
    class OfferingProvider: OfferingProviderUseCase {
        
        public typealias Offering = TiqetsAPI.Offerings.Response
        
        public var offeringsPublisher: NetswiftResponsePublisher<Offering>
        
        public init(state: State<Offering, NetswiftError> = .success(value: .mock)) {
            offeringsPublisher = CurrentValueSubject(state).eraseToAnyPublisher()
        }
    }
}

public extension TiqetsAPI.Offerings.Response {
    static var mock: Self {
        .init(venues: [
            .init(id: "1",
                  name: "Test",
                  imageURL: .init(string: "https://aws-tiqets-cdn.imgix.net/images/content/9d3735fc2e334bc3a3b68822a2e801b4.jpg?w=315&h=210&dpr=2&q=40&fit=crop")!,
                  currency: "EUR",
                  price: "10,-",
                  rating: 3.4),
            .init(id: "2",
                  name: "Test 2",
                  imageURL: .init(string: "https://aws-tiqets-cdn.imgix.net/images/content/7fc58eaa938444d3963660eed00b3ce0.jpg?auto=format&dpr=2&fit=crop&h=200&ixlib=python-3.2.1&q=25&w=300&s=6efcc07eb8bdd167894165e382662eb4")!,
                  currency: "EUR",
                  price: "5.50",
                  rating: 4.8),
        ],
              exhibitions: [
                .init(id: "3",
                      name: "Test3",
                      imageURL: .init(string: "https://aws-tiqets-cdn.imgix.net/images/content/770f93d18e1544728550c132f46b3f86.jpg?auto=format&fit=crop&h=275&ixlib=python-3.2.1&q=70&w=275&s=137d1f6c19d580c9958508b0ca26384e")!,
                      currency: "EUR",
                      price: "9.90",
                      location: "Amsterdam",
                      startDate: .now,
                      endDate: .now.addingTimeInterval(TimeInterval(60 * 60 * 24)))
              ])
    }
}
