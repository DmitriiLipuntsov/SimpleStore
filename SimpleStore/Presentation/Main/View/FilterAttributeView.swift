//
//  FilterAttributeView.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 06.01.2023.
//

import SwiftUI

struct FilterAttributeView: View {
    
    let title: String
    let items: [String]
    @Binding var selectedType: String
    
    @State var dropDownIsShow = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom(AppFonts.markProMedium, size: 18))
                .foregroundColor(AppColors.titleText)
            
            Button {
                dropDownIsShow.toggle()
            } label: {
                HStack {
                    HStack {
                        Text(selectedType)
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
            .overlay(
                VStack {
                    if dropDownIsShow {
                        DropDownView(
                            types: items,
                            selectedType: $selectedType,
                            isShow: $dropDownIsShow
                        )
                        .frame(height: 300)
                        .padding(.top, 220)
                    }
                }
            )
        }
        .padding(.top)

    }
}

//#if DEBUG
//struct FilterAttributeView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterAttributeView(items: ["Sumsung", "Motorola", "Xiaomi"], viewModel: MainViewModel())
//    }
//}
//#endif
