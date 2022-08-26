//
//  OfferingsView+ViewModel.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import Combine
import Networking

extension OfferingsView {
    class ViewModel: ObservableObject {
        @Published
        var venues: [Venue] = []
        
        @Published
        var exhibitions: [Exhibition] = []
        
        init() {
            TiqetsAPI.Offerings.getAll.perform { [weak self] response in
                guard let self = self else { return }
                
                switch response {
                case .success(let offerings):
                    self.venues = offerings.venues
                    self.exhibitions = offerings.exhibitions
                    
                case .failure:
                    break
                }
            }
        }
    }
}
