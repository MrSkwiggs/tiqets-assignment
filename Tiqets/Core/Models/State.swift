//
//  State.swift
//  Core
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import Netswift

public enum State<Value, Error: Swift.Error> {
    case initial
    case loading
    case success(value: Value)
    case failure(error: Error)
}

internal extension State {
    init(from result: NetswiftResult<Value>) where Error == NetswiftError {
        switch result {
        case .failure(let error):
            self = .failure(error: error)
            
        case .success(let value):
            self = .success(value: value)
        }
    }
}
