//
//  TopTab.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/8/21.
//

import SwiftUI

struct TopTab: View {
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    var label: String
    
    var tag: Int
    
    @Binding var selectedTag: Int
    
    var numberMark: Int = 0
    
    var body: some View {
        ZStack {
            Text(label)
                .foregroundColor(selectedTag == tag ? .secondary : .subText)
                .font(selectedTag == tag ? .bold12 : .regular12)
                .padding(.bottom, 15)
                .padding(.top, 10)
                .overlay(
                    Rectangle()
                        .frame(width: mainViewDataModel.loggedInUserGroup != nil ? UIScreen.main.bounds.width/4 : UIScreen.main.bounds.width/3, height: 4)
                        .foregroundColor(selectedTag == tag ? .secondary : .clear)
                        .transition(.move(edge: .bottom)),
                    alignment: .bottom)
                .onTapGesture(perform: {
                    withAnimation() {
                        if selectedTag != tag {
                            selectedTag = tag
                        }
                    }
                })
            if (numberMark != 0) {
                if (numberMark > 9) {
                    Text("9+")
                        .font(.regular10)
                        .foregroundColor(.white)
                        .background(
                            Circle()
                                .fill(Color(hex: "f16161"))
                                .frame(width: 17, height: 17)
                        )
                        .offset(x: 28, y: -6)
                }else{
                Text(String(numberMark))
                    .font(.regular10)
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .fill(Color(hex: "f16161"))
                            .frame(width: 17, height: 17)
                    )
                    .offset(x: 28, y: -6)
                }
            }
        }
    }
}
