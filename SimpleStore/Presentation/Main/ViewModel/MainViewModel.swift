//
//  MainViewModel.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 23.12.2022.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    private weak var repository: ProductsRepositoryProtocol?
    private weak var coordinator: CoordinatorProtocol?
    
    private var allHotSells: [HotSaleModel] = []
    @Published var hotSells: [HotSaleModel] = []
    
    private var allBestSells: [BestSellerModel] = []
    @Published var bestSells: [BestSellerModel] = []
    
    @Published var filterViewIsShow = false
    @Published var filterAttributeModel: FilterAttributeModel = FilterAttributeModel(
        brand: FilterAttributeModel.brands[0],
        price: FilterAttributeModel.priceStrings[0],
        size: "4.5 to 5.5 inches"
    )
    

    
    @Published var categories: [CategoryModel] = [
        CategoryModel(title: "Phones", iconName: "iphone", isSelected: true),
        CategoryModel(title: "Computer", iconName: "laptopcomputer"),
        CategoryModel(title: "Health", iconName: "bolt.heart"),
        CategoryModel(title: "Book", iconName: "books.vertical"),
        CategoryModel(title: "Watches", iconName: "applewatch"),
        CategoryModel(title: "Earphones", iconName: "airpodsmax")
    ]
    
    @Published var searchText: String = ""
    
    var nameSelectedCategory: String {
        categories[indexSelectedCategory].title
    }
    
    private var indexSelectedCategory = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: CoordinatorProtocol, repository: ProductsRepository) {
        self.coordinator = coordinator
        self.repository = repository
        addSubscribers()
    }
    
    func categoryPressed(index: Int) {
        categories[indexSelectedCategory].isSelected = false
        categories[index].isSelected = true
        indexSelectedCategory = index
    }
    
    func byButtonPressed(index: Int) {
        
    }
    
    func showDetail(item: BestSellerModel) {
        coordinator?.show(.detail)
    }
    
    func filterItems() {
        filterViewIsShow = false
        bestSells = allBestSells.filter({ model in
            let priceIsCorrect = filterAttributeModel.getPriceAttr ~= model.price
            let modelIsCorrect = model.title.lowercased().contains(filterAttributeModel.brand.lowercased())
            return priceIsCorrect && modelIsCorrect
        })
    }
    
    private func addSubscribers() {
        repository?.hotSellsPublisher.sink { [weak self] hotSells in
            DispatchQueue.main.async {
                self?.allHotSells = hotSells
                self?.hotSells = hotSells
            }
        }
        .store(in: &cancellables)
        
        repository?.bestSellersPublisher.sink { [weak self] bestSells in
            DispatchQueue.main.async {
                self?.allBestSells = bestSells
                self?.bestSells = bestSells
            }
        }
        .store(in: &cancellables)
    }
}
