//
//  Category.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 03.01.2023.
//

import Foundation

struct CategoryModel {
    let id = UUID()
    let title: String
    let iconName: String
    var isSelected: Bool
    
    init(title: String, iconName: String, isSelected: Bool = false) {
        self.title = title
        self.iconName = iconName
        self.isSelected = isSelected
    }
}
