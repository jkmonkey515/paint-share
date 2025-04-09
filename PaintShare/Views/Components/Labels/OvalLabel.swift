//
//  OvalLabel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/9/21.
//

import SwiftUI

struct OvalLabel: View {
    
    var text: String
    
    var width: CGFloat
    
    var height: CGFloat
    
    var bgColor: Color
    
    var font: Font = .bold10
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: height/2.0)
                .fill(bgColor)
                .frame(width: width, height: height)
            Text(text)
                .font(font)
                .foregroundColor(.white)
        }
    }
}
