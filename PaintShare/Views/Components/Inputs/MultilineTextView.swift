//
//  MultilineTextView.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/14/21.
//

import SwiftUI

struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String
    @State var placeHolder: String
    @Binding var didStartEditing: Bool
    
    func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.delegate = context.coordinator
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.font = UIFont(name: "NotoSansCJKjp-Medium", size: 16)
        view.textColor = Color.mainText.uiColor()
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if !didStartEditing && text == "" && placeHolder != "" {
            uiView.textColor = UIColor.lightGray
            uiView.text = placeHolder
        }
        else {
            uiView.textColor = UIColor.black
            uiView.text = text
        }
    }
    
    class Coordinator : NSObject, UITextViewDelegate {

            var parent: MultilineTextView

            init(_ uiTextView: MultilineTextView) {
                self.parent = uiTextView
            }

            func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
                return true
            }

            func textViewDidChange(_ textView: UITextView) {
                self.parent.text = textView.text
            }
        }
}
