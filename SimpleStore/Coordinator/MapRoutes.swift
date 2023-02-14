//
//  MapRoutes.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 04.02.2023.
//

import Foundation

enum NavigationTranisitionStyle {
    case push
    case presentModally
    case presentFullscreen
}

enum MapRoutes {
    case main
    case detail
    
    var transition: NavigationTranisitionStyle {
        switch self {
        case .main:
            return .push
        case .detail:
            return .push
        }
    }
}
