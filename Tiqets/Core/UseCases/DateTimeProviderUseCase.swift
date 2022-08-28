//
//  DateTimeProviderUseCase.swift
//  Core
//
//  Created by Dorian Grolaux on 28/08/2022.
//

import Foundation

public protocol DateTimeProviderUseCase {
    var currentDate: Date { get }
}

public class DateTimeProvider: DateTimeProviderUseCase {
    public var currentDate: Date { Date() }
}

public extension Mock {
    class DateTimeProvider: DateTimeProviderUseCase {
        public let currentDate: Date
        
        init(date: Date = .init()) {
            currentDate = date
        }
        
        public static let firstOfJune2021: DateTimeProvider = {
            let calendar = Calendar(identifier: .gregorian)
            let components = DateComponents(calendar: calendar,
                                            year: 2021,
                                            month: 6,
                                            day: 1)
            
            return .init(date: calendar.date(from: components)!)
        }()
    }
}
