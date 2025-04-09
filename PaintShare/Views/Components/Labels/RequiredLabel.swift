//
//  RequiredMark.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/14/21.
//

import SwiftUI

struct RequiredLabel: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.caution)
                .frame(width: 44, height: 21)
            Text("必須")
                .font(.regular11)
                .foregroundColor(.white)
        }
    }
}
