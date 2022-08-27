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
    
    var offeringsViewModel: OfferingsView.ViewModel {
        .init(offeringProvider: root.offeringProvider)
    }
    
    func detailViewModel(_ venue: Venue) -> DetailView.ViewModel {
        .init(venue, favoritesProvider: root.favoritesProvider)
    }
    
    func detailViewModel(_ exhibition: Exhibition) -> DetailView.ViewModel {
        .init(exhibition, favoritesProvider: root.favoritesProvider)
    }
}
