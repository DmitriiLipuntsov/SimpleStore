//
//  CustomImageView.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 06.01.2023.
//

import SwiftUI

struct CustomImageView<Placeholder: View, ProgressBlock: View>: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject var viewModel: ImageViewModel
    
    let placeholder: Placeholder
    let progressBlock: ProgressBlock
    
    init(
        imageUrlString: String,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder progressBlock: () -> ProgressBlock
    ) {
        _viewModel = .init(wrappedValue: ImageViewModel(imageUrlString: imageUrlString))
        self.placeholder = placeholder()
        self.progressBlock = progressBlock()
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                progressBlock
            case .error:
                placeholder
            case .success(let image):
                Image(uiImage: image)
                    .resizable()
            }
        }
    }
}

#if DEBUG
struct CustomImageView_Previews: PreviewProvider {
    static var previews: some View {
        CustomImageView(imageUrlString: Mocks.imageUrlString, placeholder: {ProgressView()}, progressBlock: {Image(systemName: "photo")})
    }
}
#endif
