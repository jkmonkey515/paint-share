//
//  ConfirmModal.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/28/21.
//

import SwiftUI

struct ConfirmModal: View {
    
    @Binding var showModal: Bool
    
    var text: String
    
    var onConfirm: () -> Void
    
    var onCancel: () -> Void = {}
    
    var confirmText: String = "OK"
    
    var cancelText: String = "キャンセル"
    
    var frameHeight: CGFloat = 271
    
    var textXPadding: CGFloat = 20
    
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
                .padding(.horizontal, textXPadding)
            Spacer()
            HStack(spacing: 28) {
                CommonButton(text: cancelText, color: Color.primary, width: 100, height: 28, onClick: {
                    self.showModal = false
                    onCancel()
                })
                CommonButton(text: confirmText, color: Color.primary, width: 100, height: 28, onClick: {
                    self.showModal = false
                    onConfirm()
                })
            }
            Spacer()
        }
        .frame(width: 303, height: frameHeight)
    }
}
