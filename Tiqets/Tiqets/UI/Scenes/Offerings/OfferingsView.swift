//
//  OfferingsView.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import SwiftUI
import Kingfisher
import Core
import Networking

struct OfferingsView: View {
    
    @EnvironmentObject
    var viewModelProvider: ViewModelProvider
    
    @StateObject
    var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                section(title: "Venues") {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.venues) { venue in
                            NavigationLink {
                                DetailView(viewModel: viewModelProvider.detailViewModel(venue))
                            } label: {
                                Card(imageURL: venue.imageURL,
                                     title: venue.name,
                                     currency: venue.currency,
                                     price: venue.price,
                                     isFavorite: viewModel.favoritesIDs.contains(venue.id)) {
                                    viewModel.userDidTapFavoriteButton(for: venue.id)
                                }
                            }
                        }
                    }
                }
                
                section(title: "Exhibitions") {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.exhibitions) { exhibition in
                            NavigationLink {
                                DetailView(viewModel: viewModelProvider.detailViewModel(exhibition))
                            } label: {
                                Card(imageURL: exhibition.imageURL,
                                     title: exhibition.name,
                                     currency: exhibition.currency,
                                     price: exhibition.price,
                                     isFavorite: viewModel.favoritesIDs.contains(exhibition.id)) {
                                    viewModel.userDidTapFavoriteButton(for: exhibition.id)
                                }
                            }
                        }
                    }
                }
            }
            
            if viewModel.hasError {
                ZStack {
                    Rectangle()
                        .fill(Color.ui(.background))
                    VStack(spacing: 32) {
                        Spacer()
                        
                        Text("😬")
                            .font(.largeTitle)
                            .foregroundColor(.text())
                        
                        Text("Something's not quite right!")
                            .font(.title)
                            .foregroundColor(.text())
                        
                        Text("We're sorry, something went wrong while fetching offerings.\n\nPlease try again")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.text(.secondary))
                        
                        Button("Retry") {
                            viewModel.userDidTapRetryButton()
                        }
                        Spacer()
                    }
                    .padding()
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
        .background(Color.ui(.background))
    }
    
    private func section<Content: View>(title: String,
                                        @ViewBuilder _ content: () -> Content) -> some View {
        Section {
            Group {
                if viewModel.isLoading {
                    ForEach(0..<2) { _ in
                        Card(imageURL: nil, title: "_____", currency: "EUR", price: "3.5", isFavorite: false) {}
                            .loading(isLoading: true)
                    }
                } else {
                    content()
                }
            }
            .padding()
        } header: {
            HStack {
                Text(title.uppercased())
                    .font(.headline)
                    .foregroundColor(.text(.secondary))
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct OfferingsView_Previews: PreviewProvider {
    static var previews: some View {
        OfferingsView(viewModel: .init(offeringProvider: Mock.OfferingProvider(),
                                       favoritesProvider: Mock.FavoritesProvider()))
        
        OfferingsView(viewModel: .init(offeringProvider: Mock.OfferingProvider(state: .loading),
                                       favoritesProvider: Mock.FavoritesProvider()))
        
        OfferingsView(viewModel: .init(offeringProvider: Mock.OfferingProvider(state: .failure(error: .init(.notAuthenticated))),
                                       favoritesProvider: Mock.FavoritesProvider()))
    }
}
