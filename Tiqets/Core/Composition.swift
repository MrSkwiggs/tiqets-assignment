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
    public let favoritesProvider: FavoritesProviderUseCase
    
    public init(tiqetsAPI: TiqetsAPI,
                dateTimeProvider: DateTimeProviderUseCase,
                networkPathMonitor: NetworkPathMonitorUseCase,
                offeringProvider: OfferingProviderUseCase,
                favoritesProvider: FavoritesProviderUseCase) {
        TiqetsAPI.configure(using: tiqetsAPI)
        self.dateTimeProvider = dateTimeProvider
        self.networkPathMonitor = networkPathMonitor
        self.offeringProvider = offeringProvider
        self.favoritesProvider = favoritesProvider
    }
}

public extension Composition {
    
    /// Main composition root for production environment
    static var main: Composition {
        .init(tiqetsAPI: .main,
              dateTimeProvider: DateTimeProvider(),
              networkPathMonitor: NetworkPathMonitor(),
              offeringProvider: OfferingProvider(),
              favoritesProvider: LocalFavoritesProvider()) // use API provider when implemented
    }
    
    /// Uses local values (doesn't depend on API availability) - greater testing & implementation flexibility
    static var debug: Composition {
        .init(tiqetsAPI: .debug,
              dateTimeProvider: Mock.DateTimeProvider.firstOfJune2021,
              networkPathMonitor: NetworkPathMonitor(),
              offeringProvider: OfferingProvider(),
              favoritesProvider: LocalFavoritesProvider())
    }
    
    /// Uses mocked data, for a static app state (useful for screenshot & promotional content)
    static var mock: Composition {
        .init(tiqetsAPI: .debug,
              dateTimeProvider: Mock.DateTimeProvider(),
              networkPathMonitor: Mock.NetworkPathMonitor(isOnline: true),
              offeringProvider: Mock.OfferingProvider(),
              favoritesProvider: Mock.FavoritesProvider())
    }
}
