//
//  Coordinator.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 09.01.2023.
//

import SwiftUI

class Coordinator: CoordinatorProtocol {
    let navigationController: UINavigationController
    let moduleBuilder = ModuleBuilder()
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
        start()
    }
    
    func start() {
        show(.main)
    }
    
    func show(_ route: MapRoutes, animated: Bool = true) {
        let view = moduleBuilder.view(route, coordinator: self)
        let viewController = UIHostingController(rootView: view)
        switch route.transition {
        case .push:
            navigationController.pushViewController(viewController, animated: animated)
        case .presentModally:
            viewController.modalPresentationStyle = .formSheet
            navigationController.present(viewController, animated: animated)
        case .presentFullscreen:
            viewController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: animated)
        }
    }
    
    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: true) { [weak self] in
            self?.navigationController.viewControllers = []
        }
    }
}
