//
//  Popup.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 07.01.2023.
//

import SwiftUI

struct PopupModifier<PopupContent>: ViewModifier where PopupContent: View {
    
    /// Controls if the sheet should be presented or not
    @Binding var isPresented: Bool
    
    /// The content to present
    var view: () -> PopupContent
    
    @State private var presenterContentRect: CGRect = .zero

    /// The rect of popup content
    @State private var sheetContentRect: CGRect = .zero

    /// The offset when the popup is displayed
    private var displayedOffset: CGFloat {
        -presenterContentRect.midY + screenHeight / 2
    }

    /// The offset when the popup is hidden
    private var hiddenOffset: CGFloat {
        if presenterContentRect.isEmpty {
            return 1000
        }
        return screenHeight - presenterContentRect.midY + sheetContentRect.height / 2 + 5
    }

    /// The current offset, based on the "presented" property
    private var currentOffset: CGFloat {
        return isPresented ? displayedOffset : hiddenOffset
    }
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.size.width
    }

    private var screenHeight: CGFloat {
        UIScreen.main.bounds.size.height
    }
    
    init(isPresented: Binding<Bool>,
         view: @escaping () -> PopupContent) {
        self._isPresented = isPresented
        self.view = view
    }
    
    // MARK: - Content Builders
    public func body(content: Content) -> some View {
        ZStack {
            content
              .frameGetter($presenterContentRect)
        }
        .overlay(sheet())
    }

    func sheet() -> some View {
        ZStack {
            self.view()
              .frameGetter($sheetContentRect)
              .frame(width: screenWidth)
              .offset(x: 0, y: currentOffset)
              .animation(Animation.easeOut(duration: 0.3), value: currentOffset)
        }
    }

    private func dismiss() {
        isPresented = false
    }

}
