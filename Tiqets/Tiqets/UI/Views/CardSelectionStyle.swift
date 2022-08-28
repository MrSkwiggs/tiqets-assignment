//
//  CardSelectionStyle.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 28/08/2022.
//

import SwiftUI

extension Button {
    var cardSelectionStyle: some View {
        return self.buttonStyle(CardSelectionStyle())
    }
}

struct CardSelectionStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .shadow(color: .ui(.shadow).opacity(configuration.isPressed ? 0.0 : 1.0),
                    radius: 6, x: 0, y: 0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
