//
//  ErrorModal.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/7/21.
//

import SwiftUI

struct ErrorModal: View {
    @Binding var showModal: Bool
    
    var text: String
    
    var onConfirm: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.primary)
                    .frame(height: 110)
                Image("info-icon")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .foregroundColor(.white)
            }
            Spacer()
            Text(text)
                .font(.regular16)
                .foregroundColor(.mainText)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            Spacer()
            CommonButton(text: "OK", color: Color.primary, width: 100, height: 28, onClick: {
                self.showModal = false
                onConfirm()
            })
            Spacer()
        }
        .frame(width: 303, height: 271)
    }
}
