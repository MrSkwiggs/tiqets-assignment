//
//  Composition.swift
//  Core
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import Networking

public class Composition {
    public let networkPathMonitor: NetworkPathMonitorUseCase
    
    public init(tiqetsAPI: TiqetsAPI,
                networkPathMonitor: NetworkPathMonitorUseCase) {
        TiqetsAPI.configure(using: tiqetsAPI)
        self.networkPathMonitor = networkPathMonitor
    }
}

public extension Composition {
    static var main: Composition {
        .init(tiqetsAPI: .main,
              networkPathMonitor: NetworkPathMonitor())
    }
    
    static var debug: Composition {
        .init(tiqetsAPI: .debug,
              networkPathMonitor: NetworkPathMonitor())
    }
}
