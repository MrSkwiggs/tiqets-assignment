//
//  RootView.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import SwiftUI
import SFSafeSymbols

struct RootView: View {
    var body: some View {
        
        
        NavigationView {
            TabView {
                OfferingsView()
                    .tabItem {
                        Label("Offerings", systemSymbol: .location)
                    }
                Text("Favorites")
                    .tabItem {
                        Label("Favorites", systemSymbol: .heart)
                    }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
