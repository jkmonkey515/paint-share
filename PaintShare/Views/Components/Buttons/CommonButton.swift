//
//  CommonButton.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/13/21.
//

import SwiftUI

struct CommonButton: View {
    
    var text: String
    
    var color: Color = Color.primary
    
    var textColor: Color = .white
    
    var radius: CGFloat = 5
    
    var width: CGFloat = 66
    
    var height: CGFloat = 28
    
    var disabled: Bool = false
    
    var picture: String = ""
    
    var isHavePicture: Bool = false
    
    var onClick: () -> Void = {}
    
    var body: some View {
        GeneralButton(onClick: {
            if (!disabled) {
                onClick()
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: radius)
                    .fill(color)
                    .opacity(disabled ? 0.35 : 1)
                    .frame(width: width, height: height)
                    .shadow(color: Color(hex: "000000").opacity(0.16), radius: 6, x: 0.0, y: 3)
                if isHavePicture == true {
                    HStack{
                        Image(systemName: picture)
                            .foregroundColor(.white)
                        Text(text)
                            .font(.regular18)
                            .foregroundColor(.white)
                    }
                }else{
                    Text(text)
                        .font(.regular18)
                        .foregroundColor(textColor)
                }
            }
        })
    }
}
