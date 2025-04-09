//
//  ColorListItem.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/04/28.
//

import SwiftUI

struct ColorListItem: View {
    
    var colorNumber: String
    
    var colorCode: String
    
    var body: some View {
        HStack{
            Text(colorNumber)
                .font(.regular16)
                .foregroundColor(.mainText)
            Spacer()
            Rectangle()
                .frame(width: 250, height: 45)
                .foregroundColor(Color(hex: colorCode))
                .shadow(color: Color(.black).opacity(0.35), radius: 6, x: 0, y: 3)
        }
    }
}
