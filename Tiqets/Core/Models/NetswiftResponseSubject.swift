//
//  NetswiftResponseSubject.swift
//  Core
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import Netswift
import Combine

internal typealias NetswiftResponseSubject<T: Codable> = CurrentValueSubject<State<T, NetswiftError>, Never>
