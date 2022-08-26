//
//  ViewModelProvider.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import Core

class ViewModelProvider: ObservableObject {
    let root: Composition
    
    init(root: Composition) {
        self.root = root
    }
    
    var offeringsViewModel: OfferingsView.ViewModel {
        .init()
    }
}
