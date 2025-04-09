//
//  ViewExtension.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/8/21.
//

import SwiftUI

extension View {
    func underlineTextField() -> some View {
        self
            .overlay(
                Rectangle().frame(height: 2), alignment: .bottom)
            .foregroundColor(Color(hex: "e0e0e0")
            )
    }
    
    func underlineListItem() -> some View {
        self
            .overlay(
                Rectangle().frame(height: 1), alignment: .bottom)
            .foregroundColor(Color(hex: "e0e0e0")
            )
    }
}

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
