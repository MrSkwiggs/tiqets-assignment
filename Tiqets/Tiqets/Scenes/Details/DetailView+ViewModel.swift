//
//  DetailView+ViewModel.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import Networking

extension DetailView {
    class ViewModel: ObservableObject {
        
        let imageURL: URL?
        let title: String
        
        @Published
        var sections: [Section]
        
        private static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, YYYY"
            return formatter
        }()
        
        init(_ venue: Venue) {
            imageURL = venue.imageURL
            title = venue.name
            sections = [
                .init(type: .price(currency: venue.currency, value: venue.price)),
                .init(type: .rating(rating: String(format: "%.1f", venue.rating)))
            ]
        }
        
        init(_ exhibition: Exhibition) {
            imageURL = exhibition.imageURL
            title = exhibition.name
            sections = [
                .init(type: .location(value: exhibition.location)),
                .init(type: .price(currency: exhibition.currency, value: exhibition.price)),
                .init(type: .dateRange(startDate: Self.dateFormatter.string(from: exhibition.startDate),
                                       endDate: Self.dateFormatter.string(from: exhibition.endDate)))
            ]
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
