//
//  Endpoints.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 03.01.2023.
//

import Foundation

struct Endpoints {
    static let store = "/654bd15e-b121-49ba-a588-960956b15175"
    static let productDetail = "/6c14c560-15c6-4248-b9d2-b4508df7d4f5"
}

struct Endpoint {
    var version: String { "/v3" }
    var path: String
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "run.mocky.io"
        
        components.path = version + path
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}

extension Endpoint {
    static func productDetail() -> Self {
        return Endpoint(path: Endpoints.productDetail)
    }
    
    static func store() -> Self {
        return Endpoint(path: Endpoints.store)
    }
}
