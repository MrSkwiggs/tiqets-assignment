//
//  TiqetsEndpoint.swift
//  Networking
//
//  Created by Dorian Grolaux on 25/08/2022.
//

import Foundation
import Netswift

public protocol TiqetsRequest: NetswiftRequest {}
public protocol TiqetsRoute: NetswiftRoute {}

public typealias TiqetsEndpoint = TiqetsRequest & TiqetsRoute

public extension TiqetsRequest where Self: TiqetsRoute {
    func serialise() -> NetswiftResult<URLRequest> {
        var request = URLRequest(url: self.url)
        
        request.setHTTPMethod(self.method)
        
        var headers = self.additionalHeaders
        
        headers.append(.contentType(contentType))
        headers.append(.accept(accept))
        
        request.setHeaders(headers)
        
        return .success(request)
    }
}
