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
        
        private let offeringProvider: OfferingProviderUseCase
        private var subscriptions: [AnyCancellable] = []
        
        init(offeringProvider: OfferingProviderUseCase) {
            self.offeringProvider = offeringProvider
            
            offeringProvider
                .offeringsPublisher
                .sink { [weak self] state in
                    guard let self = self else { return }
                    
                    switch state {
                    case .initial, .loading:
                        self.isLoading = true
                        
                    case .success(let response):
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            self.venues = response.venues
                            self.exhibitions = response.exhibitions
                            self.hasError = false
                            self.isLoading = false
                        }
                        
                    case .failure:
                        self.hasError = true
                        self.isLoading = false
                    }
                }
                .store(in: &subscriptions)
        }
    }
}
