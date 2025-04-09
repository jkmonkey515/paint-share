//
//  CommonTextField.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/8/21.
//

import SwiftUI

struct CommonTextField: View {
    
    var label: String
    
    var placeholder: String
    
    //var width: CGFloat = .infinity
    
    var required: Bool = false
    
    var font: Font = .medium16
    
    var color: Color = .mainText
    
    @Binding var value: String
    
    var disabled: Bool = false
    
    var commabled: Bool = false
    
    var cardNumberSpace:Bool = false
    
    var showOptionalTag: Bool = false
    
    var inputTwoCount: Bool = false
    
    var additionalMessage: String = ""
    
    var validationMessage: String = ""
    
    var warningMessage: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 15) {
                Text(label)
                    .font(.regular12)
                    .foregroundColor(.mainText)
                if (required) {
                    RequiredLabel()
                }
                else if (showOptionalTag) {
                    OptionalLabel()
                }
            }
            if (warningMessage != "") {
                Text(warningMessage)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(nil)
                    .font(.regular12)
                    .foregroundColor(Color(hex: "#FF0000"))
            }
            TextField(placeholder, text: $value)
                .padding(.bottom, 2)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .font(font)
                .foregroundColor(color)
                .underlineTextField()
                .disabled(disabled)
                .onChange(of: value) { newValue in
                    if commabled {
                        value = Constants.showTheComma(source: newValue)
                    }
                    if cardNumberSpace{
                        value = Constants.showTheSpace(source: newValue)
                    }
                    
                    if inputTwoCount{
                        value = Constants.inputTwoCount(source: newValue)
                    }
                }
                .onAppear {
                    if commabled {
                        value = Constants.showTheComma(source: value)
                    }
                    if cardNumberSpace{
                        value = Constants.showTheSpace(source: value)
                    }
                    if inputTwoCount{
                        value = Constants.inputTwoCount(source: value)
                    }
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
