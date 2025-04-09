//
//  OvalButton.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/8/21.
//

import SwiftUI

struct OvalButton: View {
    
    var text: String
    
    var width: CGFloat = 256
    
    var height: CGFloat = 50
    
    var disabled: Bool = false
    
    var onClick: () -> Void = {}
    
    var body: some View {
        GeneralButton(onClick: {
            if (!disabled) {
                onClick()
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.primary)
                    .frame(width: width, height: height)
                    .shadow(color: Color(hex: "000000").opacity(0.16), radius: 3, x: 0.0, y: 3)
                Text(text)
                    .font(.regular20)
                    .foregroundColor(.white)
            }
        })
    }
}
