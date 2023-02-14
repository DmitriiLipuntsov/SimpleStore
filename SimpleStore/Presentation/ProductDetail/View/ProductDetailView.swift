//
//  ProductDetailView.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 08.01.2023.
//

import SwiftUI

struct ProductDetailView: View {
        
    @ObservedObject var viewModel: ProductDetailViewModel
    
    private let imageHeight: CGFloat = 335
    
    var body: some View {
        ZStack(alignment: .top) {
            AppColors.mainBackground.ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        viewModel.pop()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 7, height: 14)
                            .padding(10)
                            .padding(.horizontal, 3.5)
                            .background(AppColors.darkBlue)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("Product Details")
                        .font(.custom(AppFonts.markProMedium, size: 18))
                        .foregroundColor(AppColors.titleText)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "bag")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .padding(10)
                            .background(AppColors.orange)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 40)
                
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .error:
                    Text("Error!")
                case .success(let model):
                    ZStack {
                        if !model.images.isEmpty {
                            TabView {
                                ForEach(0..<model.images.count, id: \.self) { index in
                                    let imageUrlString = model.images[index]
                                    ZStack {
                                        CustomImageView(
                                            imageUrlString: imageUrlString,
                                            placeholder: {
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .scaledToFit()
                                            },
                                            progressBlock: {
                                                ProgressView()
                                            }
                                        )
                                        .scaledToFit()
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color.white)
                                    .clipped()
                                    .cornerRadius(20)
                                    .padding(.horizontal, 10)
                                }
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    .frame(width: .screenWidth - 60, height: imageHeight)
                    .padding(.top, 20)
                    
                    VStack {
                        HStack {
                            Text("Galaxy Note 20 Ultra")
                                .font(.custom("Mark Pro Medium", size: 24))
                                .foregroundColor(AppColors.titleText)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "heart")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .padding(10)
                                    .padding(.horizontal, 3.5)
                                    .background(AppColors.darkBlue)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        HStack {
                            RatingStarsView(rating: .constant(model.rating))
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 20)
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
    }
}

#if DEBUG
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: ProductDetailViewModel(coordinator: Coordinator(), repository: ProductDetailRepository()))
    }
}
#endif
