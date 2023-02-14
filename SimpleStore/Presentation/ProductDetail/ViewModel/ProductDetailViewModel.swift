//
//  ProductDetailViewModel.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 08.01.2023.
//

import Foundation
import Combine

enum ProductDetailViewState {
    case loading
    case success(ProductDetailModel)
    case error
}

class ProductDetailViewModel: ObservableObject {
    
    private weak var repository: ProductDetailRepositoryProtocol?
    private weak var coordinator: CoordinatorProtocol?
    
    @Published var state: ProductDetailViewState = .loading
    @Published var productDetail: ProductDetailModel?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: CoordinatorProtocol, repository: ProductDetailRepositoryProtocol) {
        self.coordinator = coordinator
        self.repository = repository
        addSubscribers()
    }
    
    func pop() {
        coordinator?.pop()
    }
    
    private func addSubscribers() {
        repository?.productDetailPublisher.sink { [weak self] product in
            if let product = product {
                self?.productDetail = product
                self?.state = .success(product)
            } else {
                self?.state = .error
            }
        }
        .store(in: &cancellables)
    }
}
