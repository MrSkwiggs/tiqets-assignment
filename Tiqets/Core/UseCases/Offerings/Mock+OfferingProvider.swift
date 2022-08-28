//
//  Mock+OfferingProvider.swift
//  Core
//
//  Created by Dorian Grolaux on 28/08/2022.
//

import Foundation
import Combine
import Networking
import Netswift

public extension Mock {
    class OfferingProvider: OfferingProviderUseCase {
        
        public typealias Offering = TiqetsAPI.Offerings.Response
        
        private var offeringsSubject: NetswiftResponseSubject<Offering> = .init(.initial)
        private let state: State<Offering, NetswiftError>
        
        public lazy var offeringsPublisher: NetswiftResponsePublisher<Offering> = {
            refresh()
            return offeringsSubject.eraseToAnyPublisher()
        }()
        
        public init(state: State<Offering, NetswiftError> = .success(value: .mock)) {
            self.state = state
            self.offeringsSubject = .init(.initial)
        }
        
        public func refresh() {
            offeringsSubject.send(.loading)
            
            // for demonstration purposes, emit success after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
                guard let self = self else { return }
                self.offeringsSubject.send(self.state)
            }
        }
    }
}

public extension TiqetsAPI.Offerings.Response {
    static var mock: Self {
        .init(venues: [
            Mock.Offerings.Venues.vanGogh,
            Mock.Offerings.Venues.moco,
        ],
              exhibitions: [
                Mock.Offerings.Exhibitions.erraticGrowth
              ])
    }
}
