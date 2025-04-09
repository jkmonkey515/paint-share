//
//  NotifyModal.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/28/21.
//

import SwiftUI

struct NotifyModal: View {
    
    @Binding var showModal: Bool
    
    var text: String
    
    var onConfirm: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.primary)
                    .frame(height: 110)
                Image("check-circle")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 60, height: 60)
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
