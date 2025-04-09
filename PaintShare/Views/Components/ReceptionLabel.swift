//
//  ReceptionLabel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/20.
//

import SwiftUI

struct ReceptionLabel: View {
    var body: some View {
        ZStack {
            Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 40, y:0));            path.addLine(to: CGPoint(x: 0, y: 40))
                       path.addLine(to: CGPoint(x: 0, y: 0))
            }
            .fill(Color(hex: "#707070").opacity(0.7))
        .frame(width: 68, height: 68)
            Text("受付終了")
                .font(.regular8)
                .foregroundColor(Color.white)
                .rotationEffect(.degrees(315))
                .padding(.top,-25)
                .padding(.leading,-35)
        }
    }
}
