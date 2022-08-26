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
    
    func refresh()
}

public class OfferingProvider: OfferingProviderUseCase {
    
    public typealias Offering = TiqetsAPI.Offerings.Response
    
    private var offeringsSubject: NetswiftResponseSubject<Offering> = .init(.initial)
    
    public lazy var offeringsPublisher: NetswiftResponsePublisher<Offering> = {
        refresh()
        return offeringsSubject.eraseToAnyPublisher()
    }()
    
    init() {}
    
    public func refresh() {
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
        
        private var offeringsSubject: NetswiftResponseSubject<Offering> = .init(.initial)
        private let state: State<Offering, NetswiftError>
        
        public lazy var offeringsPublisher: NetswiftResponsePublisher<Offering> = { offeringsSubject.eraseToAnyPublisher() }()
        
        public init(state: State<Offering, NetswiftError> = .success(value: .mock)) {
            self.state = state
            self.offeringsSubject = .init(state)
        }
        
        public func refresh() {
            offeringsSubject.send(.loading)
            offeringsSubject.send(state)
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
