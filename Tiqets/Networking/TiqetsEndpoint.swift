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

public extension TiqetsRequest  where IncomingType == Data, Response: Decodable {
    func deserialise(_ incomingData: IncomingType) -> NetswiftResult<Response> {
        do {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let decodedResponse = try decoder.decode(Response.self, from: incomingData)
            return .success(decodedResponse)
            
        } catch let error as DecodingError {
            return .failure(.init(category: .responseDecodingError(error: error), payload: incomingData))
        } catch {
            return .failure(.init(category: .unexpectedResponseError, payload: incomingData))
        }
    }
}
