//
//  CommonSecureField.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/04/19.
//

import SwiftUI

struct CommonSecureField: View {
    
    var label: String
    
    var placeholder: String
    
    //var width: CGFloat = .infinity
    
    var required: Bool = false
    
    var showOptionalTag: Bool = false
    
    var font: Font = .medium16
    
    var color: Color = .mainText
    
    @State var showFlag: Bool = false
    
    @Binding var value: String
    
    var validationMessage: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 15) {
                Text(label)
                    .font(.regular12)
                    .foregroundColor(.mainText)
                if (required) {
                    RequiredLabel()
                } else if (showOptionalTag) {
                    OptionalLabel()
                }
            }
            HStack(spacing: 0) {
                if self.showFlag{
                    TextField(placeholder, text: $value)
                        .font(font)
                        .foregroundColor(color)
                        .disableAutocorrection(true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .padding(.bottom, 1.5)
                } else {
                    SecureField(placeholder, text: $value)
                        .font(font)
                        .foregroundColor(color)
                        .padding(.bottom, 3)
                }
                GeneralButton(onClick: {
                    self.showFlag.toggle()
                }, label: {
                    Image(systemName: self.showFlag ? "eye.slash" : "eye")
                        .resizable()
                        .frame(width: 30, height: 20)
                        .foregroundColor(.black)
                        .opacity(0.5)
                })
            }
            .underlineTextField()
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
