//
//  GeneralButton.swift
//  PaintShare
//
//  Created by Lee on 2023/3/9.
//

import SwiftUI

struct GeneralButton<Label>: View where Label: View {
    
    var disabled: Bool = false
    
    var onClick: () -> Void = {}
    
    @ViewBuilder var label : () -> Label
    
    @State private var onlyOnceClick: Bool = false
    
    var body: some View {
        Button(action: {
            if (!disabled) {
                if !onlyOnceClick {
                    
                    onClick()
                    
                    self.onlyOnceClick = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.onlyOnceClick = false
                    })
                }
            }else{
                onClick()
            }
        }, label: label)
    }
}

/*
extension Button where Label == SwiftUI.Label<Image, Text> {
    public init(oneClickAction: @escaping () -> Void, @ViewBuilder label: () -> Label) {
        self.init(action: {
            
            oneClickAction()
            
        }, label: label)
    }
}
*/
