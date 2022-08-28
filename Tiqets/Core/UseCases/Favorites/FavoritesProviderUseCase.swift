//
//  FavoritesProviderUseCase.swift
//  Core
//
//  Created by Dorian Grolaux on 27/08/2022.
//

import Foundation
import Networking
import Combine
import Netswift

public protocol FavoritesProviderUseCase {
    var favoritesIDPublisher: NetswiftResponsePublisher<Set<String>> { get }
    
    func addFavorite(byID id: String) -> NetswiftResponsePublisher<Void>
    func removeFavorite(byID id: String) -> NetswiftResponsePublisher<Void>
}

public class LocalFavoritesProvider: FavoritesProviderUseCase {
    
    typealias KeyStore = FavoritesKeyStore
    
    static let keyStore: KeyStore = .init()
    
    @KeyStoreSubject(keyStore: keyStore, key: .favoritesIDs, default: [])
    private var favoritesIDs: Set<String>
    
    public lazy var favoritesIDPublisher: NetswiftResponsePublisher<Set<String>> = {
        $favoritesIDs
            .subject
            .map {
                .success(value: $0)
            }
            .eraseToAnyPublisher()
    }()
    
    public func addFavorite(byID id: String) -> NetswiftResponsePublisher<Void> {
        let subject: NetswiftResponseSubject<Void> = .init(.initial)
        
        // for demonstration purposes, emit success after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            self?.favoritesIDs.update(with: id)
            subject.send(.success(value: ()))
            subject.send(completion: .finished)
        }
        
        return subject.eraseToAnyPublisher()
    }
    
    public func removeFavorite(byID id: String) -> NetswiftResponsePublisher<Void> {
        let subject: NetswiftResponseSubject<Void> = .init(.initial)
        
        // for demonstration purposes, emit success after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            self?.favoritesIDs.remove(id)
            subject.send(.success(value: ()))
            subject.send(completion: .finished)
        }
        
        return subject.eraseToAnyPublisher()
    }
}

public extension Mock {
    class FavoritesProvider: FavoritesProviderUseCase {
        
        @Published
        private var favoritesIDs: Set<String> = ["123", "321"]
        
        public init() {}
        
        public var favoritesIDPublisher: NetswiftResponsePublisher<Set<String>> {
            $favoritesIDs
                .map {
                    .success(value: $0)
                }
                .eraseToAnyPublisher()
        }
        
        public func addFavorite(byID id: String) -> NetswiftResponsePublisher<Void> {
            favoritesIDs.update(with: id)
            
            return NetswiftResponseSubject(.success(value: ())).eraseToAnyPublisher()
        }
        
        public func removeFavorite(byID id: String) -> NetswiftResponsePublisher<Void> {
            favoritesIDs.remove(id)
            
            return NetswiftResponseSubject(.success(value: ())).eraseToAnyPublisher()
        }
        
        
    }
}
