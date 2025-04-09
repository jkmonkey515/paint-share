//
//  MailLoginButton.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/05/27.
//

import SwiftUI

struct MailLoginButton: View {
    var text: String
    
    var width: CGFloat = 263
    
    var height: CGFloat = 50
    
    var disabled: Bool = false
    
    var onClick: () -> Void = {}
    
    var body: some View {
        GeneralButton(onClick: {
            if (!disabled) {
                onClick()
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: "FFAC5A"))
                    .frame(width: width, height: height)
                    .shadow(color: Color(hex: "000000").opacity(0.16), radius: 3, x: 0.0, y: 3)
                HStack {
                    Image(systemName:"envelope.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    Text(text)
                        .font(.regular18)
                        .foregroundColor(.white)
                        .frame(height: 30)
                }
            }
        })
    }
}

