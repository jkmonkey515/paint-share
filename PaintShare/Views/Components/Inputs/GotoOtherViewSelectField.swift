//
//  GotoOtherViewSelectField.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/07/06.
//

import SwiftUI

struct GotoOtherViewSelectField: View {
    var label: String
    
    var placeholder: String
    
    var required: Bool = false
    
    var font: Font = .medium16
    
    var color: Color = .mainText
    
    var onClick: () -> Void = {}
    
    @Binding var value: String
    
    var additionalMessage: String = ""
    
    var infoMessage: String = ""
    
    var validationMessage: String = ""
    
    var isDisable: Bool = true
    
    var isGoToNewView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 15) {
                Text(label)
                    .font(.regular12)
                    .foregroundColor(.mainText)
                if (required) {
                    RequiredLabel()
                }
            }
            HStack(spacing: 0) {
                TextField(placeholder, text: $value)
                    .font(font)
                    .foregroundColor(color)
                    .disabled(isDisable)
                GeneralButton(onClick: {
                    hideKeyboard()
                    onClick()
                }, label: {
                        Image("ionic-ios-arrow-down")
                            .resizable()
                            .frame(width: 16.38, height: 9.37, alignment: .center)
                            .rotationEffect(.degrees(-90))
                            .offset(x:-4, y:-5)
                })
            }
            .padding(.bottom, 2)
            .underlineTextField()
            if (!infoMessage.isEmpty) {
                Text(infoMessage)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(nil)
                    .font(.regular12)
                    .foregroundColor(.mainText)
            }
            if (!additionalMessage.isEmpty) {
                Text(additionalMessage)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(nil)
                    .font(.regular12)
                    .foregroundColor(Color(hex: "#707070"))
            }
            if (!validationMessage.isEmpty) {
                Text(validationMessage)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(nil)
                    .font(.bold12)
                    .foregroundColor(.caution)
            }
        }

    }
}

