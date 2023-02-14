//
//  FilterAttributeModel.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 06.01.2023.
//

import Foundation

class FilterAttributeModel {
    static let brands = ["Samsung", "Xiaomi", "Motorola"]
    static let prices = [0...1000, 1000...2500, 2500...5000, 5000...10000,  10000...Int.max]
    
    static let priceStrings: [String] = ["$0 - $1000", "$1000 - $2500", "$2500 - $5000", "$5000 - $10000", "$10000 - ..."]
    
    var brand: String
    var price: String
    var size: String
    
    init(brand: String, price: String, size: String) {
        self.brand = brand
        self.price = price
        self.size = size
    }
    
    var getPriceAttrString: String {
        switch getPriceAttr {
        case 0...1000:
            return "$0 - $1000"
        case 1000...2500:
            return "$1000 - $2500"
        case 2500...5000:
            return "$2500 - $5000"
        case 5000...10000:
            return "$5000 - $10000"
        case 5000...Int.max:
            return "$10000 - ..."
        default:
            return "0"
        }
    }
    
    var getPriceAttr: ClosedRange<Int> {
        switch price {
        case "$0 - $1000":
            return 0...1000
        case "$1000 - $2500":
            return 1000...2500
        case "$2500 - $5000":
            return 2500...5000
        case "$5000 - $10000":
            return 5000...10000
        case "$10000 - ...":
            return 5000...Int.max
        default:
            return 5000...Int.max
        }
    }
    
    
}
