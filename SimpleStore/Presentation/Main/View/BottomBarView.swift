//
//  BottomBarView.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 06.01.2023.
//

import SwiftUI

struct BottomBarView: View {
    var body: some View {
        HStack {
            Spacer()
            
            Circle()
                .fill(.white)
                .frame(width: 8, height: 8)
            
            Text("Explorer")
                .font(.custom(AppFonts.markProBold, size: 15))
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "bag")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(Color.white)
            
            Spacer()
            
            Image(systemName: "heart")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(Color.white)
            
            Spacer()
            
            Image(systemName: "person")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(Color.white)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 72)
        .background(AppColors.darkBlue)
        .cornerRadius(30)
    }
}

#if DEBUG
struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView()
    }
}
#endif
