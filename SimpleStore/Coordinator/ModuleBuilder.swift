//
//  ModuleBuilder.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 04.02.2023.
//

import SwiftUI

protocol ModuleBuilderProtocol: AnyObject {
    associatedtype V: View
    
    func view(_ type: MapRoutes, coordinator: CoordinatorProtocol) -> V
}

class ModuleBuilder: ModuleBuilderProtocol {
    
    private let productRepository = ProductsRepository()
    private let productDetailRepository = ProductDetailRepository()
    
    init() {
    }
    
    @ViewBuilder
    func view(_ type: MapRoutes, coordinator: CoordinatorProtocol) -> some View {
        switch type {
        case .main:
            let vm = MainViewModel(coordinator: coordinator, repository: productRepository)
            MainView(viewModel: vm)
        case .detail:
            let vm = ProductDetailViewModel(coordinator: coordinator, repository: productDetailRepository)
            ProductDetailView(viewModel: vm)
        }
    }
}
