//
//  RootView.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import SwiftUI
import SFSafeSymbols
import Core

struct RootView: View {
    
    @EnvironmentObject
    var viewModelProvider: ViewModelProvider
    
    @StateObject
    var viewModel: ViewModel
    
    var body: some View {
        TabView {
            NavigationView {
                VStack(alignment: .leading) {
                    Group {
                        Text("Activities available on ")
                            .foregroundColor(.text(.secondary))
                        + Text("\(viewModel.currentDate)")
                            .bold()
                            .foregroundColor(.text())
                    }
                    .padding()
                    OfferingsView(viewModel: viewModelProvider.offeringsViewModel)
                }
                .background(Color.ui(.background))
                .navigationTitle("Offerings")
            }.tabItem {
                Label("Offerings", systemSymbol: .listBullet)
            }
            .navigationViewStyle(.stack)
            
            NavigationView {
                OfferingsView(viewModel: viewModelProvider.favoriteOfferingsViewModel)
                    .navigationTitle("Favorites")
            }
            .tabItem {
                Label("Favorites", systemSymbol: .heart)
            }
            .navigationViewStyle(.stack)
        }
        .background(
            Color.ui(.background)
        )
    }
}


struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: .init(dateTimeProvider: Mock.DateTimeProvider.firstOfJune2021))
            .environmentObject(ViewModelProvider(root: .mock))
    }
}
