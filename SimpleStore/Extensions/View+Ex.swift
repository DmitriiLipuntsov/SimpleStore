//
//  View+Ex.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 07.01.2023.
//

import SwiftUI

extension View {
    func popup<PopupContent: View>(
        isPresented: Binding<Bool>,
        view: @escaping () -> PopupContent
    ) -> some View {
        self.modifier(
            PopupModifier(
                isPresented: isPresented,
                view: view
            )
        )
    }
}

extension View {
    func frameGetter(_ frame: Binding<CGRect>) -> some View {
        modifier(FrameGetterModifier(frame: frame))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
