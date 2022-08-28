//
//  ViewModelProvider.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import Networking
import Core

class ViewModelProvider: ObservableObject {
    let root: Composition
    
    init(root: Composition) {
        self.root = root
    }
    
    var rootViewModel: RootView.ViewModel {
        .init(dateTimeProvider: root.dateTimeProvider)
    }
    
    var offeringsViewModel: OfferingsView.ViewModel {
        .init(offeringProvider: root.offeringProvider, favoritesProvider: root.favoritesProvider)
    }
    
    var favoriteOfferingsViewModel: OfferingsView.ViewModel {
        .init(offeringProvider: root.favoriteOfferingsProvider, favoritesProvider: root.favoritesProvider)
    }
    
    func detailViewModel(_ venue: Venue) -> DetailView.ViewModel {
        .init(venue, favoritesProvider: root.favoritesProvider)
    }
    
    func detailViewModel(_ exhibition: Exhibition) -> DetailView.ViewModel {
        .init(exhibition, favoritesProvider: root.favoritesProvider)
    }
}
