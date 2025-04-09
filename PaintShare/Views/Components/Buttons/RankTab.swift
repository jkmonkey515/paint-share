//
//  RankTab.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/23/21.
//

import SwiftUI

struct RankTab: View {
    
    // -1: all, 0: smile, 1: smile2, 2: sad-face
    var rankType: Int
    
    var count: Int
    
    @Binding var selectedType: Int
    
    var body: some View {
        VStack(spacing: 0) {
            if (rankType == -1) {
                Text("すべて")
                    .foregroundColor(.mainText)
                    .font(.medium16)
            } else {
                RankLabel(rank: rankType)
            }
            Text(String(count))
                .foregroundColor(.subText)
                .font(.regular14)
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity
            )
        .padding(.top, 10)
        .padding(.bottom, 15)
        .overlay(
            Rectangle()
                .frame(height: 2)
                .foregroundColor(selectedType == rankType ? .primary : .clear)
                .transition(.move(edge: .bottom)),
            alignment: .bottom)
        .onTapGesture(perform: {
            withAnimation() {
                if selectedType != rankType {
                    selectedType = rankType
                }
            }
        })
    }
}
