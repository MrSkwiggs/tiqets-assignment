//
//  DetailView+ViewModel.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import Combine
import Networking
import Core

extension DetailView {
    class ViewModel: ObservableObject, Identifiable {
        
        let imageURL: URL?
        let title: String
        
        @Published
        var sections: [Section]
        
        @Published
        var isFavorite: Bool = false
        
        @Published
        var favoriteStateHasError: Bool = false
        
        @Published
        var favoriteStateIsLoading: Bool = true
        
        private static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, YYYY"
            return formatter
        }()
        
        private let offeringID: String
        private let favoritesProvider: FavoritesProviderUseCase
        private var subscriptions: [AnyCancellable] = []
        
        init(_ venue: Venue, favoritesProvider: FavoritesProviderUseCase) {
            self.offeringID = venue.id
            self.favoritesProvider = favoritesProvider
            imageURL = venue.imageURL
            title = venue.name
            sections = [
                .init(type: .price(currency: venue.currency, value: venue.price)),
                .init(type: .rating(rating: String(format: "%.1f", venue.rating)))
            ]
            
            setupSubscriptions()
        }
        
        init(_ exhibition: Exhibition, favoritesProvider: FavoritesProviderUseCase) {
            self.offeringID = exhibition.id
            self.favoritesProvider = favoritesProvider
            imageURL = exhibition.imageURL
            title = exhibition.name
            sections = [
                .init(type: .location(value: exhibition.location)),
                .init(type: .price(currency: exhibition.currency, value: exhibition.price)),
                .init(type: .dateRange(startDate: Self.dateFormatter.string(from: exhibition.startDate),
                                       endDate: Self.dateFormatter.string(from: exhibition.endDate)))
            ]
            
            setupSubscriptions()
        }
        
        private func setupSubscriptions() {
            favoritesProvider
                .favoritesIDPublisher
                .sink { [weak self] state in
                    guard let self = self else { return }
                    
                    switch state {
                    case .failure:
                        self.favoriteStateHasError = true
                        self.favoriteStateIsLoading = false
                        
                    case .initial, .loading:
                        self.favoriteStateIsLoading = true
                        self.favoriteStateHasError = false
                        
                    case .success(let value):
                        self.favoriteStateIsLoading = false
                        self.favoriteStateHasError = false
                        
                        self.isFavorite = value.contains(self.offeringID)
                    }
                }
                .store(in: &subscriptions)
        }
        
        func userDidTapFavoriteButton() {
            switch isFavorite {
            case true:
                favoritesProvider
                    .removeFavorite(byID: offeringID)
                    .sink { [weak self] state in
                        guard let self = self else { return }
                        
                        switch state {
                        case .failure:
                            self.favoriteStateHasError = true
                            self.favoriteStateIsLoading = false
                            
                        case .initial, .loading:
                            self.favoriteStateIsLoading = true
                            self.favoriteStateHasError = false
                            
                        case .success:
                            self.favoriteStateIsLoading = false
                            self.favoriteStateHasError = false
                        }
                    }
                    .store(in: &subscriptions)
                
            case false:
                favoritesProvider
                    .addFavorite(byID: offeringID)
                    .sink { [weak self] state in
                        guard let self = self else { return }
                        
                        switch state {
                        case .failure:
                            self.favoriteStateHasError = true
                            self.favoriteStateIsLoading = false
                            
                        case .initial, .loading:
                            self.favoriteStateIsLoading = true
                            self.favoriteStateHasError = false
                            
                        case .success:
                            self.favoriteStateIsLoading = false
                            self.favoriteStateHasError = false
                        }
                    }
                    .store(in: &subscriptions)
            }
        }
    }
}

extension DetailView.ViewModel {
    struct Section: Identifiable, Equatable {
        let id: String = UUID().uuidString
        
        let type: SectionType
    }
    
    enum SectionType: Equatable {
        case price(currency: String, value: String)
        case location(value: String)
        case rating(rating: String)
        case dateRange(startDate: String, endDate: String)
    }
}
