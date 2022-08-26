//
//  TiqetsAPIHTTPPerformer.swift
//  Networking
//
//  Created by Dorian Grolaux on 26/08/2022.
//

import Foundation
import Netswift

class TiqetsAPIHTTPPerformer: NetswiftHTTPPerformer {
    
    override func perform(_ request: URLRequest) async -> NetswiftResult<Data?> {
        await session.perform(request).asNetswiftResult
    }
    
    override func perform(_ request: URLRequest, completion: @escaping (NetswiftResult<Data?>) -> Void) -> NetswiftTask {
        session.perform(request) {
            completion($0.asNetswiftResult)
        }
    }
    
    override func perform(_ request: URLRequest, deadline: DispatchTime = .now() + .seconds(5), completion: @escaping (NetswiftResult<Data?>) -> Void) -> NetswiftTask {
        let dispatchGroup = DispatchGroup()
        
        if dispatchGroup.wait(timeout: deadline) == .timedOut {
            completion(.failure(.init(category: .timedOut, payload: nil)))
        }
        
        dispatchGroup.enter()
        return self.perform(request) { result in
            dispatchGroup.leave()
            
            completion(result)
        }
    }
}

extension NetswiftHTTPResponse {
    var asNetswiftResult: NetswiftResult<Data?> {
        if let error = error {
            return .failure(.init(category: .generic(error: error), payload: data))
        }
        
        return .success(data)
    }
}
