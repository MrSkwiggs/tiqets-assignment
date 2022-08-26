//
//  NetworkPathMonitorUseCase.swift
//  Core
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import Combine
import Network
import SystemConfiguration

/**
 A Network Path Monitor tracks whether or not the device can reach the internet
 */
public protocol NetworkPathMonitorUseCase {
    var isConnectedToTheInternetSubject: CurrentValueSubject<Bool, Never> { get }
}

public class NetworkPathMonitor: NetworkPathMonitorUseCase {
    
    public var isConnectedToTheInternetSubject: CurrentValueSubject<Bool, Never> = .init(false)
    
    private let nwPathMonitor: NWPathMonitor
    
    init() {
        self.nwPathMonitor = .init()
        nwPathMonitor.pathUpdateHandler = { [weak self] path in
            self?.isConnectedToTheInternetSubject.value = Self.isConnectedToNetwork()
        }
        
        nwPathMonitor.start(queue: .global(qos: .utility))
    }
    
    /**
     Taken from [StackOverflow](https://stackoverflow.com/questions/30743408/check-for-internet-connection-with-swift)
     */
    private class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}

public extension Mock {
    class NetworkPathMonitor: NetworkPathMonitorUseCase {
        public var isConnectedToTheInternetSubject: CurrentValueSubject<Bool, Never>
        
        init(isOnline: Bool) {
            self.isConnectedToTheInternetSubject = .init(isOnline)
        }
    }
}
