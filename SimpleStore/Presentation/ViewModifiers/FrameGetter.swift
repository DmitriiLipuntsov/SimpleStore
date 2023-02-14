//
//  FrameGetter.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 07.01.2023.
//

import SwiftUI

struct FrameGetterModifier: ViewModifier {
    
    @Binding var frame: CGRect
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy -> AnyView in
                    let rect = proxy.frame(in: .global)
                    if rect.integral != self.frame.integral {
                        DispatchQueue.main.async {
                            self.frame = rect
                        }
                    }
                    return AnyView(EmptyView())
                })
    }
}
