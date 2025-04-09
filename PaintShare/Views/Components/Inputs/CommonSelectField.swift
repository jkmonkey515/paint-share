//
//  CommonSelectField.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/04/26.
//

import SwiftUI

struct CommonSelectField: View {
    
    var label: String
    
    var labelFont: Font = .regular12
    
    var labelTextColor: Color = .mainText
    
    var placeholder: String
    
    var required: Bool = false
    
    var showOptionalTag: Bool = false
    
    var font: Font = .medium16
    
    var color: Color = .mainText
    
    var image: String = "ionic-ios-arrow-down"
    
    var onClick: () -> Void = {}
    
    @Binding var value: String
    
    var additionalMessage: String = ""
    
    var validationMessage: String = ""
    
    var isDisable: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 15) {
                Text(label)
                    .font(labelFont)
                    .foregroundColor(labelTextColor)
                if (required) {
                    RequiredLabel()
                } else if (showOptionalTag) {
                    OptionalLabel()
                }
            }
            HStack(spacing: 0) {
                TextField(placeholder, text: $value)
                    .font(font)
                    .foregroundColor(color)
                    .disabled(isDisable)
                GeneralButton(onClick: {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    onClick()
                    hideKeyboard()
                }, label: {
                    Image(image)
                        .resizable()
                        .frame(width: 16.38, height: 9.37, alignment: .center)
                        .offset(x:-10, y:-5)
                })
            }
            .padding(.bottom, 2)
            .underlineTextField()
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
        .onTapGesture(perform: {
            onClick()
            hideKeyboard()
        })

    }
}
