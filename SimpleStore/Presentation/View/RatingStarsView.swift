//
//  RatingStarsView.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 09.01.2023.
//

import SwiftUI

struct RatingStarsView: View {
    
    @Binding var rating: Double
    
    var maxRating: Int = 5
    
    var onImage = Image(systemName: "star.fill")
    var offImage: Image?
    
    var offColor = Color.gray
    var onColor = Color.yellow
        
    var body: some View {
        HStack {
            ForEach(1..<maxRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > Int(rating) ? offColor : onColor)
                    .onTapGesture {
                        rating += Double(number) * 0.1
                    }
            }
        }
    }
    
    private func image(for number: Int) -> Image {
        if number > Int(rating) {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

#if DEBUG
struct RatingStarsView_Previews: PreviewProvider {
    static var previews: some View {
        RatingStarsView(rating: .constant(4.6))
    }
}
#endif
