//
//  CircleTextField.swift
//  PaintShare
//
//  Created by Lee on 2022/12/23.
//

import SwiftUI

struct CircleTextField: View {
    
    var label: String
    
    var placeholder: String
        
    var required: Bool = false
    
    var font: Font = .regular13
    
    var color: Color = .mainText
    
    @Binding var value: String
    
    var disabled: Bool = false
    
    var commabled: Bool = false
    
    var cardNumberSpace:Bool = false
    
    var showOptionalTag: Bool = false
    
    var validationMessage: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 15) {
                Text(label)
                    .font(.regular13)
                    .foregroundColor(.mainText)
                if (required) {
                    RequiredLabel()
                }
                else if (showOptionalTag) {
                    OptionalLabel()
                }
            }
            ZStack{
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(Color(hex: "#C9C9C9"), lineWidth: 1)
                    .frame(height: 35)
                TextField(placeholder, text: $value)
                    .padding(.bottom, 2)
                    .padding(.horizontal, 10)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(font)
                    .foregroundColor(color)
                    .disabled(disabled)
                    .onChange(of: value) { newValue in
                        if commabled {
                            value = Constants.showTheComma(source: newValue)
                        }
                        if cardNumberSpace{
                            value = Constants.showTheSpace(source: newValue)
                        }
                    }
                    .onAppear {
                        if commabled {
                            value = Constants.showTheComma(source: value)
                        }
                        if cardNumberSpace{
                            value = Constants.showTheSpace(source: value)
                        }
                    }
            }
            .padding(.top, 10)
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
