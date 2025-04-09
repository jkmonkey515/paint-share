//
//  MultilineTextField.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/14/21.
//

import SwiftUI

struct MultilineTextField: View {
    var label: String
    
    var placeholder: String
    
    // var width: CGFloat = .infinity
    
    var height: CGFloat = 200
    
    var required: Bool = false
    
    @Binding var value: String
    
    @State var didStartEditing = false
    
    var disabled: Bool = false
    
    var validationMessage: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                Text(label)
                    .font(.regular12)
                    .foregroundColor(.mainText)
                if (required) {
                    RequiredLabel()
                }
            }
            MultilineTextView(text: $value, placeHolder: placeholder, didStartEditing: $didStartEditing)
                .disabled(disabled)
                .disableAutocorrection(true)
                .underlineTextField()
                .onTapGesture {
                    didStartEditing = true
                }
            if (!validationMessage.isEmpty) {
                Text(validationMessage)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(nil)
                    .font(.bold12)
                    .foregroundColor(.caution)
            }
        }
        .frame(height: height)
    }
}
