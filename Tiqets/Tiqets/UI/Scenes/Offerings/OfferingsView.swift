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
                        if viewModel.venues.isEmpty {
                            Text("No venues")
                                .foregroundColor(.text(.secondary))
                        } else {
                            ForEach(viewModel.venues) { venue in
                                Button {
                                    viewModel.presentedDetails = viewModelProvider.detailViewModel(venue)
                                } label: {
                                    Card(imageURL: venue.imageURL,
                                         title: venue.name,
                                         currency: venue.currency,
                                         price: venue.price,
                                         isFavorite: viewModel.favoritesIDs.contains(venue.id)) {
                                        viewModel.userDidTapFavoriteButton(for: venue.id)
                                    }
                                }
                                .cardSelectionStyle
                            }
                        }
                    }
                }
                
                section(title: "Exhibitions") {
                    LazyVStack(spacing: 16) {
                        if viewModel.exhibitions.isEmpty {
                            Text("No exhibitions")
                                .foregroundColor(.text(.secondary))
                        } else {
                            ForEach(viewModel.exhibitions) { exhibition in
                                Button {
                                    viewModel.presentedDetails = viewModelProvider.detailViewModel(exhibition)
                                } label: {
                                    Card(imageURL: exhibition.imageURL,
                                         title: exhibition.name,
                                         currency: exhibition.currency,
                                         price: exhibition.price,
                                         isFavorite: viewModel.favoritesIDs.contains(exhibition.id)) {
                                        viewModel.userDidTapFavoriteButton(for: exhibition.id)
                                    }
                                }
                                .cardSelectionStyle
                            }
                        }
                    }
                }
            }
            
            if viewModel.hasError {
                ZStack {
                    Rectangle()
                        .fill(Color.ui(.background))
                    VStack(spacing: 16) {
                        Spacer()
                        
                        Image(systemSymbol: .exclamationmarkIcloudFill)
                            .font(.largeTitle)
                            .foregroundColor(.text(.secondary))
                        
                        Text("Something's not quite right!")
                            .font(.title3)
                            .foregroundColor(.text())
                        
                        Text("We're sorry, something went wrong while fetching offerings.")
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
        .sheet(item: $viewModel.presentedDetails) { viewModel in
            DetailView(viewModel: viewModel)
        }
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
            .padding(.horizontal)
            .padding(.bottom)
        } header: {
            HStack {
                Text(title.uppercased())
                    .font(.headline)
                    .foregroundColor(.text(.secondary))
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
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
