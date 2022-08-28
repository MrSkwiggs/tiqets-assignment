//
//  MockTiqetsAPIFailingPerformer.swift
//  Networking
//
//  Created by Dorian Grolaux on 28/08/2022.
//

import Foundation
import Netswift

/**
 An HTTP Performer which always fails
 */
class MockTiqetsAPIFailingPerformer: NetswiftHTTPPerformer {
    
    override func perform(_ request: URLRequest) async -> NetswiftResult<Data?> {
        return .failure(.init(.requestError))
    }
    
    override func perform(_ request: URLRequest, completion: @escaping (NetswiftResult<Data?>) -> Void) -> NetswiftTask {
        completion(.failure(.init(.requestError)))
        return URLSessionDataTask()
    }
    
    override func perform(_ request: URLRequest, deadline: DispatchTime = .now() + .seconds(5), completion: @escaping (NetswiftResult<Data?>) -> Void) -> NetswiftTask {
        completion(.failure(.init(.requestError)))
        return URLSessionDataTask()
    }
}
