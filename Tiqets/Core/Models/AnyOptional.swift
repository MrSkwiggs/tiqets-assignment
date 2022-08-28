//
//  AnyOptional.swift
//  Core
//
//  Created by Dorian Grolaux on 27/08/2022.
//

import Foundation

/// Convenience type-eraser for optionals
protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}
