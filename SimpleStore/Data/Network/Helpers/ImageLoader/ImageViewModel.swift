//
//  ImageViewModel.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 06.01.2023.
//

import UIKit
import Combine

class ImageViewModel: ObservableObject {
    
    enum ImageViewState {
        case loading
        case success(UIImage)
        case error
    }
    
    @Published var state: ImageViewState = .loading
    
    private var cancellables = Set<AnyCancellable>()
    
    init(imageUrlString: String) {
        getImage(urlString: imageUrlString)
    }
    
    private func getImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid image string url")
        }
        
        NetworkManager().getImage(url: url, headers: [:])
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    DispatchQueue.main.async {
                        self.state = .error
                    }
                }
            }, receiveValue: { [weak self] image in
                guard let self = self else {
                    return
                }
                
                DispatchQueue.main.async {
                    if let image = image {
                        self.state = .success(image)
                    } else {
                        self.state = .error
                    }
                }
            }
            )
            .store(in: &cancellables)
    }
}
