//
//  BestCellView.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 06.01.2023.
//

import SwiftUI

struct BestCellView: View {
    
    let model: BestSellerModel
    
    private var isFavoriteImageName: String {
        return model.isFavorite ? "heart.fill" : "heart"
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                    CustomImageView(
                        imageUrlString: model.imageUrlString,
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
                    .padding(.horizontal, 10)
                    .frame(height: 168)
                    
                    HStack {
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 25, height: 25)
                            
                            Image(systemName: isFavoriteImageName)
                                .resizable()
                                .frame(width: 11, height: 10)
                                .foregroundColor(AppColors.orange)
                        }
                    }
                    .shadow(color: Color.black.opacity(0.15), radius: 10)
                    .padding(.top, 12)
                    .padding(.trailing, 5)
                }
                .frame(height: 177)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("$\(model.discontPrice)")
                            .font(.custom(AppFonts.markProBold, size: 16))
                            .foregroundColor(AppColors.titleText)
                            .multilineTextAlignment(.leading)
                        
                        Text("$\(model.price)")
                            .font(.custom(AppFonts.markProMedium, size: 10))
                            .strikethrough()
                            .foregroundColor(AppColors.textGray)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.bottom, 1)
                    
                    Text(model.title)
                        .font(.custom(AppFonts.markProRegular, size: 10))
                        .foregroundColor(AppColors.titleText)
                    
                }
                .padding(.leading, 21)
                .padding(.bottom, 15)
            }
        }
        .frame(width: .screenWidth / 2 - 10 - 17)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(
            color: Color(red: 0.6, green: 0.7, blue: 0.8).opacity(0.1),
            radius: 40, x:0, y:0
        )
    }
}

#if DEBUG
struct BestCellView_Previews: PreviewProvider {
    static var previews: some View {
        BestCellView(model: Mocks.bestSellerModel)
    }
}
#endif
