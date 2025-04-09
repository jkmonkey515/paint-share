//
//  RankLabel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/9/21.
//

import SwiftUI

struct RankCountsLabel: View {
    
    var rank0Count: Int
    
    var rank1Count: Int
    
    var rank2Count: Int
    
    var imageSize: CGFloat = 12.4
    
    var font: Font = Font.light10
    
    var textWidth: CGFloat = 20
    
    var body: some View {
        HStack(spacing: 10) {
            HStack(spacing:3) {
                Image("smile")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                Text(String(rank0Count))
                    .font(font)
                    .foregroundColor(.mainText)
                    .frame(width: textWidth)
            }
            
            HStack(spacing:3) {
                Image("smile2")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                Text(String(rank1Count))
                    .font(font)
                    .foregroundColor(.mainText)
                    .frame(width: textWidth)
            }
            
            HStack(spacing:3) {
                Image("sad-face")
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                Text(String(rank2Count))
                    .font(font)
                    .foregroundColor(.mainText)
                    .frame(width: textWidth)
            }
        }
    }
}
