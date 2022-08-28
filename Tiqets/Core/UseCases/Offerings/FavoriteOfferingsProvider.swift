//
//  FavoriteOfferingsProvider.swift
//  Core
//
//  Created by Dorian Grolaux on 28/08/2022.
//

import Foundation
import Combine

public class FavoriteOfferingsProvider: OfferingProviderUseCase {
    
    private let allOfferingsProvider: OfferingProviderUseCase
    private let favoritesProvider: FavoritesProviderUseCase
    
    init(allOfferingsProvider: OfferingProviderUseCase, favoritesProvider: FavoritesProviderUseCase) {
        self.allOfferingsProvider = allOfferingsProvider
        self.favoritesProvider = favoritesProvider
    }
    
    public lazy var offeringsPublisher: NetswiftResponsePublisher<Offering> = {
        refresh()
        return allOfferingsProvider
            .offeringsPublisher
            .linkStates(favoritesProvider.favoritesIDPublisher)
            .mapSuccessState { (offerings, favorites) in
                return .init(venues: offerings.venues.filter({ favorites.contains($0.id) }),
                             exhibitions: offerings.exhibitions.filter({ favorites.contains($0.id) }))
            }
            .eraseToAnyPublisher()
    }()
    
    public func refresh() {
        allOfferingsProvider.refresh()
    }
}
