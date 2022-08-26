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
    @StateObject
    var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            section(title: "Venues") {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.venues) { venue in
                        NavigationLink {
                            DetailView(viewModel: .init(venue))
                        } label: {
                            Card(imageURL: venue.imageURL,
                                 title: venue.name,
                                 currency: venue.currency,
                                 price: venue.price)
                        }
                    }
                }
            }
            
            section(title: "Exhibitions") {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.exhibitions) { exhibition in
                        NavigationLink {
                            DetailView(viewModel: .init(exhibition))
                        } label: {
                            Card(imageURL: exhibition.imageURL,
                                 title: exhibition.name,
                                 currency: exhibition.currency,
                                 price: exhibition.price)
                        }
                    }
                }
            }
        }
        .navigationTitle("Offerings")
    }
    
    private func section<Content: View>(title: String,
                                        @ViewBuilder _ content: () -> Content) -> some View {
        Section {
            Group {
                if viewModel.isLoading {
                    ForEach(0..<5) { _ in
                        Card(imageURL: nil, title: "_____", currency: "EUR", price: "3.5")
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
                    .foregroundColor(.gray.opacity(0.5))
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct OfferingsView_Previews: PreviewProvider {
    static var previews: some View {
        OfferingsView(viewModel: .init(offeringProvider: Mock.OfferingProvider()))
        
        OfferingsView(viewModel: .init(offeringProvider: Mock.OfferingProvider(state: .loading)))
    }
}
