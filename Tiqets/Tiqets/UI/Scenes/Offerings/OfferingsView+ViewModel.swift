//
//  OfferingsView+ViewModel.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import Combine
import Core
import Networking

extension OfferingsView {
    class ViewModel: ObservableObject {
        
        @Published
        var venues: [Venue] = []
        
        @Published
        var exhibitions: [Exhibition] = []
        
        @Published
        var isLoading: Bool = true
        
        @Published
        var hasError: Bool = false
        
        @Published
        var areFavoritesLoading: Bool = true
        
        @Published
        var favoritesIDs: Set<String> = []
        
        private let offeringProvider: OfferingProviderUseCase
        private let favoritesProvider: FavoritesProviderUseCase
        private var subscriptions: [AnyCancellable] = []
        
        init(offeringProvider: OfferingProviderUseCase, favoritesProvider: FavoritesProviderUseCase) {
            self.offeringProvider = offeringProvider
            self.favoritesProvider = favoritesProvider
            
            offeringProvider
                .offeringsPublisher
                .sink { [weak self] state in
                    guard let self = self else { return }
                    
                    switch state {
                    case .initial, .loading:
                        self.isLoading = true
                        self.hasError = false
                        
                    case .success(let response):
                        self.venues = response.venues
                        self.exhibitions = response.exhibitions
                        self.hasError = false
                        self.isLoading = false
                        
                    case .failure:
                        self.hasError = true
                        self.isLoading = false
                    }
                }
                .store(in: &subscriptions)
            
            favoritesProvider
                .favoritesIDPublisher
                .sink { [weak self] state in
                    guard let self = self else { return }
                    
                    switch state {
                    case .initial, .loading:
                        self.areFavoritesLoading = true
                    case .success(let value):
                        self.favoritesIDs = value
                        self.areFavoritesLoading = false
                    case .failure:
                        self.areFavoritesLoading = false
                    }
                }
                .store(in: &subscriptions)
        }
        
        func userDidTapRetryButton() {
            offeringProvider.refresh()
        }
        
        func userDidTapFavoriteButton(for id: String) {
            if favoritesIDs.contains(id) {
                _ = favoritesProvider.removeFavorite(byID: id)
            } else {
                _ = favoritesProvider.addFavorite(byID: id)
            }
        }
    }
}
