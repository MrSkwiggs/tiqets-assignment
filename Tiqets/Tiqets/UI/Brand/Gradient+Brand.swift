//
//  Gradient+Brand.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 28/08/2022.
//

import SwiftUI

extension LinearGradient {
    static var background: LinearGradient {
        LinearGradient(colors: [.gradient(.background(.start)), .gradient(.background(.end))],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }
}
