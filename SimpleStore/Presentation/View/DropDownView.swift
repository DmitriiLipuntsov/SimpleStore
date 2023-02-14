//
//  DropDownView.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 07.01.2023.
//

import SwiftUI

struct DropDownView: View {
    
    let types: [String]
    @Binding var selectedType: String
    @Binding var isShow: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<types.count, id: \.self) { index in
                    let type = types[index]
                    ZStack {
                        Text(type)
                            .font(.system(size: 15, weight: .bold))
                            .padding(.vertical, 10)
                            .onTapGesture {
                                selectedType = type
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .background(type == selectedType ? AppColors.orange : Color.white)
                    .cornerRadius(20)
                    .padding(.top, index == 0 ? 10 : 0)
                    
                    if index < types.count - 1 {
                        Rectangle()
                            .frame(height: 1.0, alignment: .bottom)
                            .foregroundColor(Color.gray.opacity(0.3))
                    }
                }
            }
        }
        .frame(maxHeight: 135)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x:0, y: 0)
    }
}

#if DEBUG
struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownView(types: ["Sumsung", "Motorola", "Xiaomi"], selectedType: .constant("Motorola"), isShow: .constant(true))
    }
}
#endif
