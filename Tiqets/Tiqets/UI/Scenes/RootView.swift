//
//  RootView.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import SwiftUI
import SFSafeSymbols

struct RootView: View {
    
    @EnvironmentObject
    var viewModelProvider: ViewModelProvider
    
    var body: some View {
        TabView {
            NavigationView {
                OfferingsView(viewModel: viewModelProvider.offeringsViewModel)
                    .navigationTitle("Offerings")
            }.tabItem {
                Label("Offerings", systemSymbol: .listBullet)
            }
            
            NavigationView {
                OfferingsView(viewModel: viewModelProvider.favoriteOfferingsViewModel)
                    .navigationTitle("Favorites")
            }
            .tabItem {
                Label("Favorites", systemSymbol: .heart)
            }
        }
        .background(
            Color.ui(.background)
        )
    }
}


struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(ViewModelProvider(root: .mock))
    }
}
