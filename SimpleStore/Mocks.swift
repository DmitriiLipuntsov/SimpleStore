//
//  Mocks.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 03.01.2023.
//

import Foundation

struct Mocks {
    static let imageUrlString = "https://cdn-2.tstatic.net/kupang/foto/bank/images/pre-order-samsung-galaxy-a71-laris-manis-inilah-rekomendasi-ponsel-harga-rp-6-jutaan.jpg"
    
    static let bestSellerImageUrlString = "https://mi92.ru/wp-content/uploads/2020/03/smartfon-xiaomi-mi-10-pro-12-256gb-global-version-starry-blue-sinij-1.jpg"
    
    static let hotSaleModel: HotSaleModel = .init(id: 1, name: "Iphone12", description: "Súper. Mega. Rápido.", imageUrlString: Mocks.imageUrlString, isNew: true)
    
    static let bestSellerModel = BestSellerModel(
        id: 1,
        price: 100,
        discontPrice: 99,
        isFavorite: true,
        imageUrlString: bestSellerImageUrlString,
        title: "Xiaomi Mi 10 Pro"
    )
    
    static let hotSaleModels: [HotSaleModel] = [
        hotSaleModel,
        HotSaleModel(id: 2, name: "Iphone8", description: "descr1", imageUrlString: Mocks.imageUrlString, isNew: true),
        HotSaleModel(id: 3, name: "IphoneXR", description: "descr2", imageUrlString: Mocks.imageUrlString, isNew: false)
    ]
}
