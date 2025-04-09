//
//  RankLabel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/22/21.
//

import SwiftUI

struct RankLabel: View {
    
    var rank: Int
    
    var body: some View {
        HStack {
            if (rank == 0) {
                Image("smile")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("良い")
                    .font(.medium16)
                    .foregroundColor(Color(hex: "f16161"))
            } else if (rank == 1) {
                Image("smile2")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("普通")
                    .font(.medium16)
                    .foregroundColor(Color(hex: "dccc3d"))
            } else {
                Image("sad-face")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("悪い")
                    .font(.medium16)
                    .foregroundColor(Color(hex: "1e94fa"))
            }
        }
    }
}
