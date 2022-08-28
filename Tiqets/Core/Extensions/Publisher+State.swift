//
//  Publisher+State.swift
//  Core
//
//  Created by Dorian Grolaux on 28/08/2022.
//

import Foundation
import Combine

extension Publisher {
    
    /**
     Allows transforming a state's value only when it is of type `.success`. Any other cases are propagated without modification.
     
     - parameters:
        - transform: The operation that is used to transform the state's success value.
     */
    func mapSuccessState<Value, Value2, Error: Swift.Error>(_ transform: @escaping (Value) -> Value2) -> AnyPublisher<State<Value2, Error>, Failure> where Output == State<Value, Error> {
        return map {
            switch $0 {
            case .success(let value):
                return .success(value: transform(value))
                
            case .initial: return .initial
            case .loading: return .loading
            case .failure(let error): return .failure(error: error)
            }
        }.eraseToAnyPublisher()
    }
    
    /**
     Combines & links the latest updates of two publisher that emit State objects in a tuple of the most fitting State
     */
    func linkStates<Value1, Value2, Error: Swift.Error>(_ otherPublisher: AnyPublisher<State<Value2, Error>, Failure>) -> AnyPublisher<State<(Value1, Value2), Error>, Failure> where Output == State<Value1, Error> {
        return combineLatest(otherPublisher)
            .map { state1, state2 in
                switch (state1, state2) {
                    // MARK: Idempotent states
                case (.initial, .initial):
                    return .initial
                case (.loading, .loading):
                    return .loading
                case (.failure(let failure1), .failure):
                    return .failure(error: failure1)
                case (.success(let value1), .success(let value2)):
                    return .success(value: (value1, value2))
                    
                    // MARK: State priority
                case (.initial, .loading), (.loading, .initial):
                    return .loading
                case (.loading, .success), (.success, .loading):
                    return .loading
                case let (.failure(error), _), let (_, .failure(error)):
                    return .failure(error: error)
                    
                    // MARK: Default
                default:
                    return .loading
                }
            }
            .eraseToAnyPublisher()
    }
}
