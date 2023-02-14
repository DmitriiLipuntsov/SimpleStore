//
//  HotCellView.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 03.01.2023.
//

import SwiftUI

struct HotCellView: View {
    
    let model: HotSaleModel
    let byButtonAction: () -> ()
    private let imageHeight: CGFloat = 182
    private let imageWidth: CGFloat = .screenWidth - 40
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack(alignment: .topLeading) {
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
            .scaledToFill()
            .frame(width: .screenWidth - 20, height: imageHeight)
            .cornerRadius(10)
            .clipped()
            
            if model.isNew {
                ZStack {
                    Circle()
                        .frame(width: 27, height: 27)
                        .foregroundColor(AppColors.orange)
                    
                    Text("New")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                    //                        .underline()
                        .multilineTextAlignment(.center)
                }
                .padding(.leading, 25)
                .padding(.top, 14)
            }
            
            VStack(alignment: .leading) {
                Text(model.name)
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 6)
                    .background(Color.black)
                    .cornerRadius(10)
                
                Text(model.description)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 6)
                    .background(Color.black)
                    .cornerRadius(5)
                
                Button {
                    byButtonAction()
                } label: {
                    Text("Buy now!")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(AppColors.titleText)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 98, height: 23)
                .background(Color.white)
                .padding(.top, 10)
                .cornerRadius(5)
            }
            .padding(.leading, 25)
            .padding(.top, 38)
            .padding(.vertical, 14)
        }
    }
}

#if DEBUG
struct HotCellView_Previews: PreviewProvider {
    static var previews: some View {
        HotCellView(model: Mocks.hotSaleModel, byButtonAction: {})
    }
}
#endif
