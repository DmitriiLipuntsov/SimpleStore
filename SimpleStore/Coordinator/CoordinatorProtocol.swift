//
//  CoordinatorProtocol.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 04.02.2023.
//

import SwiftUI

protocol CoordinatorProtocol: AnyObject { //: SomeInjectableProtocol
    var navigationController: UINavigationController { get }
    
    func start()
    func show(_ route: MapRoutes, animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func dismiss(animated: Bool)
}

extension CoordinatorProtocol {
    func show(_ route: MapRoutes, animated: Bool = true) {
        show(route, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        pop(animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        pop(animated: animated)
    }
    func dismiss(animated: Bool = true) {
        dismiss(animated: animated)
    }
}
