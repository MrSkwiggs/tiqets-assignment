//
//  NetswiftResponsePublisher.swift
//  Core
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import Netswift
import Combine

public typealias NetswiftResponsePublisher<T: Codable> = AnyPublisher<State<T, NetswiftError>, Never>
