//
//  LabelButton.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/26/21.
//

import SwiftUI

struct LabelButton: View {
    var text: String
    
    var color: Color = Color.primary
    
    var width: CGFloat = 66
    
    var height: CGFloat = 28
    
    var disabled: Bool = false
    
    var onClick: () -> Void = {}
    
    @State private var onlyOnceClick: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(color)
                .frame(width: width, height: height)
                .shadow(color: Color(hex: "000000").opacity(0.16), radius: 6, x: 0.0, y: 3)
            Text(text)
                .font(.regular14)
                .foregroundColor(.white)
        }
        .onTapGesture(perform: {
            if (!disabled) {
                if !onlyOnceClick {
                    
                    onClick()
                    
                    self.onlyOnceClick = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        self.onlyOnceClick = false
                    })
                }
            }
        })
    }
}
