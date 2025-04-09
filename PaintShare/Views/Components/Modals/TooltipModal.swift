//
//  TooltipModal.swift
//  PaintShare
//
//  Created by Limeng Ruan on 6/14/21.
//

import SwiftUI

struct TooltipModal: View {
    
    @Binding var showModal: Bool
    
    var title: String
    
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.primary)
                Text(title)
                    .font(.bold16)
                    .foregroundColor(.secondary)
            }
            Text(description)
                .font(.regular14)
                .foregroundColor(.mainText)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
        }
        .padding(.all, 15)
    }
}
