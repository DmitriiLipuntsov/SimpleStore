//
//  CategoryCellView.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 23.12.2022.
//

import SwiftUI

struct CategoryCellView: View {
    
    let category: CategoryModel
    
    private var backgroundColor: Color {
        return category.isSelected ? AppColors.orange : .white
    }
    
    private var iconColor: Color {
        return category.isSelected ? .white : AppColors.categoryIconGray
    }
    
    private var titleColor: Color {
        return category.isSelected ? AppColors.orange : AppColors.darkBlue
    }
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: category.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(iconColor)
            }
            .frame(width: 71, height: 71)
            .background(backgroundColor)
            .clipShape(Circle())
            
            Text(category.title)
                .font(.custom(AppFonts.markProMedium, size: 12))
                .foregroundColor(titleColor)
                .tracking(-0.33)
                .multilineTextAlignment(.center)
        }
    }
}

#if DEBUG
struct CategoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCellView(category: .init(title: "Phones", iconName: "iphone"))
    }
}
#endif
