//
//  StatusModal.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/26/21.
//

import SwiftUI

struct StatusModal: View {
    
    @Binding var showModal: Bool
    
    var text: String
    
    var body: some View {
        VStack {
            Text(text)
                .font(.regular16)
                .foregroundColor(.mainText)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
        .frame(width: 303, height: 180)
    }
}
