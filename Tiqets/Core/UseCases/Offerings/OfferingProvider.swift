//
//  OfferingProvider.swift
//  Core
//
//  Created by Dorian Grolaux on 28/08/2022.
//

import Foundation
import Combine
import Networking

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
