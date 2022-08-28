//
//  Networking.swift
//  Networking
//
//  Created by Dorian Grolaux on 25/08/2022.
//

import Foundation
import Netswift

public struct TiqetsAPI {
    
    fileprivate static var shared: TiqetsAPI = .init()
    
    public static func configure(using sharedInstance: TiqetsAPI) {
        shared = sharedInstance
    }
    
    private let performer: NetswiftNetworkPerformer
    
    private init(performer: NetswiftNetworkPerformer = NetswiftPerformer()) {
        self.performer = performer
    }
    
    fileprivate func perform<Endpoint: TiqetsEndpoint>(_ endpoint: Endpoint,
                                                       deadline: DispatchTime? = nil,
                                                       _ handler: @escaping NetswiftHandler<Endpoint.Response>) -> NetswiftTask? {
        return performer.perform(endpoint, deadline: deadline) { result in
            DispatchQueue.main.async {
                handler(result)
            }
        }
    }
    
    fileprivate func perform<Endpoint: TiqetsEndpoint>(_ endpoint: Endpoint) async -> NetswiftResult<Endpoint.Response> {
        return await performer.perform(endpoint)
    }
}

public extension NetswiftRequestPerformable where Self: TiqetsEndpoint {
    @discardableResult func perform(_ handler: @escaping NetswiftHandler<Self.Response>) -> NetswiftTask? {
        return TiqetsAPI.shared.perform(self, handler)
    }
    
    @discardableResult func perform(deadline: DispatchTime, _ handler: @escaping NetswiftHandler<Self.Response>) -> NetswiftTask? {
        return TiqetsAPI.shared.perform(self, deadline: deadline, handler)
    }
    
    func perform() async -> NetswiftResult<Self.Response> {
        return await TiqetsAPI.shared.perform(self)
    }
}

public extension TiqetsAPI {
    static var main: TiqetsAPI {
        .init()
    }
    
    static var debug: TiqetsAPI {
        .init(performer: NetswiftPerformer(requestPerformer: TiqetsAPIHTTPPerformer()))
    }
    
    static var failing: TiqetsAPI {
        .init(performer: NetswiftPerformer(requestPerformer: MockTiqetsAPIFailingPerformer()))
    }
}
