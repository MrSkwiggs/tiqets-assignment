//
//  Composition.swift
//  Core
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import Networking

public class Composition {
    public let dateTimeProvider: DateTimeProviderUseCase
    public let networkPathMonitor: NetworkPathMonitorUseCase
    public let offeringProvider: OfferingProviderUseCase
    public let favoriteOfferingsProvider: OfferingProviderUseCase
    public let favoritesProvider: FavoritesProviderUseCase
    
    public init(tiqetsAPI: TiqetsAPI,
                dateTimeProvider: DateTimeProviderUseCase,
                networkPathMonitor: NetworkPathMonitorUseCase,
                offeringProvider: OfferingProviderUseCase,
                favoriteOfferingsProvider: OfferingProviderUseCase,
                favoritesProvider: FavoritesProviderUseCase) {
        TiqetsAPI.configure(using: tiqetsAPI)
        self.dateTimeProvider = dateTimeProvider
        self.networkPathMonitor = networkPathMonitor
        self.offeringProvider = offeringProvider
        self.favoriteOfferingsProvider = favoriteOfferingsProvider
        self.favoritesProvider = favoritesProvider
    }
}

public extension Composition {
    
    /// Main composition root for production environment
    static var main: Composition {
        
        let offeringsProvider: OfferingProviderUseCase = OfferingProvider()
        let favoriteOfferingsProvider: FavoritesProviderUseCase = LocalFavoritesProvider()
        
        return .init(tiqetsAPI: .main,
                     dateTimeProvider: DateTimeProvider(),
                     networkPathMonitor: NetworkPathMonitor(),
                     offeringProvider: offeringsProvider,
                     favoriteOfferingsProvider: FavoriteOfferingsProvider(allOfferingsProvider: offeringsProvider,
                                                                          favoritesProvider: favoriteOfferingsProvider),
                     favoritesProvider: favoriteOfferingsProvider) // use API provider when implemented
    }
    
    /// Uses local values (doesn't depend on API availability) - greater testing & implementation flexibility
    static var debug: Composition {
        
        let offeringsProvider: OfferingProviderUseCase = OfferingProvider()
        let favoriteOfferingsProvider: FavoritesProviderUseCase = LocalFavoritesProvider()
        
        return .init(tiqetsAPI: .debug,
                     dateTimeProvider: Mock.DateTimeProvider.firstOfJune2021,
                     networkPathMonitor: NetworkPathMonitor(),
                     offeringProvider: offeringsProvider,
                     favoriteOfferingsProvider: FavoriteOfferingsProvider(allOfferingsProvider: offeringsProvider,
                                                                          favoritesProvider: favoriteOfferingsProvider),
                     favoritesProvider: favoriteOfferingsProvider)
    }
    
    /// Uses mocked data, for a static app state (useful for screenshot & promotional content)
    static var mock: Composition {
        .init(tiqetsAPI: .debug,
              dateTimeProvider: Mock.DateTimeProvider(),
              networkPathMonitor: Mock.NetworkPathMonitor(isOnline: true),
              offeringProvider: Mock.OfferingProvider(),
              favoriteOfferingsProvider: Mock.OfferingProvider(),
              favoritesProvider: Mock.FavoritesProvider())
    }
}
