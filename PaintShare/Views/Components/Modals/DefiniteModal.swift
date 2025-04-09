//
//  DefiniteModal.swift
//  PaintShare
//
//  Created by Lee on 2022/5/31.
//

import SwiftUI

struct DefiniteModal: View {
    
    @Binding var showModal: Bool
    
    var title: String
    
    var content: String
    
    var color: Color = .mainText
    
    var confirmButtonText: String = "OK"
    
    var onConfirm: () -> Void
    
    var onCancel: () -> Void = {}
    

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
            Text(title)
                .font(.regular16)
                .foregroundColor(.mainText)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.bottom, 5)
            Text(content)
                .font(.regular9)
                .foregroundColor(color)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 20)
            
            Spacer()
            HStack(spacing: 28) {
                CommonButton(text: "キャンセル", color: Color.primary, width: 100, height: 28, onClick: {
                    self.showModal = false
                    onCancel()
                })
                CommonButton(text: confirmButtonText, color: Color.primary, width: 100, height: 28, onClick: {
                    self.showModal = false
                    onConfirm()
                })
            }
            Spacer()
        }
        .frame(width: 303, height: 271)
    }
}
