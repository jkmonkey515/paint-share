//
//  BottomTab.swift
//  PaintShare
//
//  Created by Lee on 2022/4/7.
//

import SwiftUI

struct BottomTab: View {
    
    var image: String
    
    var label: String
    
    var tag: Int
    
    @Binding var selectedTag: Int
    
    var numberMark: Int = 0
    
    var body: some View {
        ZStack {
            VStack{
                Image(image)
                    .renderingMode(image == "camera" ? .none : .template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: image == "camera" ? 75 : 45, height: image == "camera" ? 75 : 25)
                    .padding(.top, image == "camera" ? -40 : 1)
                    .foregroundColor(selectedTag == tag ? .secondary : .subText)
                    .onTapGesture(perform: {
                        withAnimation() {
                            if selectedTag != tag {
                                selectedTag = tag
                            }
                        }
                    })
                Text(label)
                    .foregroundColor(selectedTag == tag ? .secondary : .subText)
                    .font(selectedTag == tag ? .bold14 : .regular14)
                    .padding(.top, image == "camera" ? -18 : -8)
                    .padding(.bottom, 20)
                    .onTapGesture(perform: {
                        withAnimation() {
                            if selectedTag != tag {
                                selectedTag = tag
                            }
                        }
                    })
                /*
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
                    }
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
                */
            }
        }
    }
}
