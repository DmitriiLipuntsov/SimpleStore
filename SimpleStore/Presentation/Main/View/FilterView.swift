//
//  FilterView.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 06.01.2023.
//

import SwiftUI

struct FilterView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    viewModel.filterViewIsShow = false
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .padding(10)
                        .background(AppColors.darkBlue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Text("Filter options")
                    .font(.custom(AppFonts.markProMedium, size: 18))
                    .foregroundColor(AppColors.titleText)
                    
                Spacer()
                
                Button {
                    viewModel.filterItems()
                } label: {
                    Text("Done")
                        .font(.custom(AppFonts.markProMedium, size: 18))
                        .foregroundColor(.white)
                }
                .frame(width: 86, height: 37)
                .background(AppColors.orange)
                .cornerRadius(10)
            }
            .padding(.horizontal, 25)
            
            VStack(alignment: .leading) {
                FilterAttributeView(
                    title: "Brand",
                    items: FilterAttributeModel.brands,
                    selectedType: $viewModel.filterAttributeModel.brand
                )
                .zIndex(10)
                
                FilterAttributeView(
                    title: "Price",
                    items: FilterAttributeModel.priceStrings,
                    selectedType: $viewModel.filterAttributeModel.price
                )
                .zIndex(9)
                
                VStack(alignment: .leading) {
                    Text("Size")
                        .font(.custom(AppFonts.markProMedium, size: 18))
                        .foregroundColor(AppColors.titleText)
                    
                    HStack {
                        HStack {
                            Text("4.5 to 5.5 inches")
                                .font(.custom(AppFonts.markProRegular, size: 18))
                                .foregroundColor(AppColors.titleText)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .resizable()
                                .frame(width: 16, height: 8)
                                .foregroundColor(AppColors.arrowGray)
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(AppColors.textGray, lineWidth: 1)
                    )
                }
                .padding(.top, 10)
                .zIndex(8)
            }
            .padding(.horizontal, 30)
        }
        .padding(.top)
        .padding(.bottom, 100)
        .background(Color.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .shadow(color: Color(red: 0.2, green: 0.4, blue: 0.6).opacity(0.2), radius:20, x:0, y:-5)
    }
}

#if DEBUG
struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(viewModel: MainViewModel(coordinator: Coordinator(), repository: ProductsRepository()))
    }
}
#endif
