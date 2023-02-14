//
//  ProductDetailService.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 08.01.2023.
//

import Foundation
import Combine

protocol ProductDetailRepositoryProtocol: AnyObject {
    var productDetailPublisher: Published<ProductDetailModel?>.Publisher { get }
}

class ProductDetailRepository: ProductDetailRepositoryProtocol {
    @Published var productDetail: ProductDetailModel?
    var productDetailPublisher: Published<ProductDetailModel?>.Publisher { $productDetail }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getData()
    }
    
    func getData() {
        let endpoint = Endpoint.productDetail()
        
        NetworkManager().get(type: ProductDetailModel.self, url: endpoint.url, headers: [:])
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] product in
                    guard let self = self else {
                        return
                    }
                    
                    self.productDetail = product
                }
            )
            .store(in: &cancellables)
    }
}
