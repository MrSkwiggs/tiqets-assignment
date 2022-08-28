//
//  RootView+ViewModel.swift
//  Tiqets
//
//  Created by Dorian Grolaux on 28/08/2022.
//

import Foundation
import Core

extension RootView {
    class ViewModel: ObservableObject {
        private let dateTimeProvider: DateTimeProviderUseCase
        
        private static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, MMMM d YYYY"
            return formatter
        }()
        
        var currentDate: String {
            Self.dateFormatter.string(from: dateTimeProvider.currentDate)
        }
        
        init(dateTimeProvider: DateTimeProviderUseCase) {
            self.dateTimeProvider = dateTimeProvider
        }
    }
}
