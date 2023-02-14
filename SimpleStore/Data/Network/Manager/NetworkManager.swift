//
//  NetworkManager.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 03.01.2023.
//

import Foundation
import Combine

protocol StoreLogicControllerProtocol: AnyObject {
    var networkController: NetworkManagerProtocol { get }

    func getStore() -> AnyPublisher<StoreEntity, Error>
    func getDetail() -> AnyPublisher<StoreEntity, Error>
}


protocol NetworkManagerProtocol: AnyObject {
    typealias Headers = [String: Any]
    
    func get<T>(
        type: T.Type,
        url: URL,
        headers: Headers
    ) -> AnyPublisher<T, Error> where T: Decodable
    
    func getImage(
        url: URL,
        headers: Headers
    ) -> AnyPublisher<Data, URLError>
    
}

class NetworkManager: NetworkManagerProtocol {
    
    func get<T: Decodable>(
        type: T.Type,
        url: URL,
        headers: Headers
    ) -> AnyPublisher<T, Error> {
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getImage(
        url: URL,
        headers: Headers
    ) -> AnyPublisher<Data, URLError> {
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest).map(\.data).eraseToAnyPublisher()
    }
}
