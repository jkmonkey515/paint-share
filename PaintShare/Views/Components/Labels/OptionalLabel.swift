//
//  OptionalLabel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 6/9/21.
//

import SwiftUI

struct OptionalLabel: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color(hex: "c5c5c5"))
                .frame(width: 44, height: 21)
            Text("任意")
                .font(.regular11)
                .foregroundColor(.white)
        }
    }
}
