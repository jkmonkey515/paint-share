//
//  CommonCheckBox.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/04/20.
//

import SwiftUI

struct CommonCheckBox: View {
    
    @Binding var checked: Bool
    
    var width: CGFloat = 28
    
    var height: CGFloat = 28
    
    var body: some View {
        Button(action: {
            self.checked.toggle()
        }) {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color(.gray), lineWidth: 1)
                .frame(width: width, height: height)
                .overlay(Image("Icon-open-check").opacity(self.checked ? 1 : 0))
        }
        .buttonStyle(PlainButtonStyle())
    }
    
}
