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
