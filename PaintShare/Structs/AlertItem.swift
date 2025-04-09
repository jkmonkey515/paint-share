//
//  AlertItem.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/08/17.
//

import SwiftUI

@propertyWrapper
struct AlertItem<Item>: DynamicProperty {
    @State private var value: Item?

    var wrappedValue: Item? {
        get { value }
        nonmutating set { value = newValue }
    }

    var projectedValue: Binding<Bool> {
        Binding(get: { value != nil }, set: { if !$0 { value = nil } })
    }
}
