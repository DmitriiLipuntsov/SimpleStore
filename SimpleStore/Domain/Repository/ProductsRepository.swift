//
//  StoreService.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 03.01.2023.
//

import Foundation
import Combine

protocol ProductsRepositoryProtocol: AnyObject {
    var hotSellsPublisher: Published<[HotSaleModel]>.Publisher { get }
    var bestSellersPublisher: Published<[BestSellerModel]>.Publisher { get }
}

class ProductsRepository: ProductsRepositoryProtocol {
    
    @Published var hotSells: [HotSaleModel] = []
    var hotSellsPublisher: Published<[HotSaleModel]>.Publisher { $hotSells }
    
    @Published var bestSellers: [BestSellerModel] = []
    var bestSellersPublisher: Published<[BestSellerModel]>.Publisher { $bestSellers }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getData()
    }
    
    func getData() {
        let endpoint = Endpoint.store()
        print(endpoint.url)
        
        NetworkManager().get(type: StoreEntity.self, url: endpoint.url, headers: [:])
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] storeData in
                    guard let self = self else {
                        return
                    }
                    
                    self.hotSells = storeData.homeStore.map { entity -> HotSaleModel in
                        return self.transformResponseToHotSaleModel(entity: entity)
                    }
                    
                    self.bestSellers = storeData.bestSeller.map { entity -> BestSellerModel in
                        return self.transformResponseToBestSallerModel(entity: entity)
                    }
                }
            )
            .store(in: &cancellables)
    }
    
    private func transformResponseToHotSaleModel(entity: HomeStore) -> HotSaleModel {
        return HotSaleModel(
            id: entity.id,
            name: entity.title,
            description: entity.subtitle,
            imageUrlString: entity.picture,
            isNew: entity.isNew ?? false
        )
    }
    
    private func transformResponseToBestSallerModel(entity: BestSeller) -> BestSellerModel {
        return BestSellerModel(
            id: entity.id,
            price: entity.priceWithoutDiscount,
            discontPrice: entity.discountPrice,
            isFavorite: entity.isFavorites,
            imageUrlString: entity.imageUrlString,
            title: entity.title
        )
    }
}
