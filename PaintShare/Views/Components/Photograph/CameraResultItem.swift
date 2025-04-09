//
//  CameraResultItem.swift
//  PaintShare
//
//  Created by Lee on 2022/7/5.
//

import SwiftUI

struct CameraResultItem: View {
    
    @EnvironmentObject var cameraDetectDataModel: CameraDetectDataModel
    
    var body: some View {
        HStack{
            HStack {
                VStack(alignment: .leading) {
                    Text("1")
                        .font(.regular14)
                        .foregroundColor(.mainText)
                        .lineLimit(1)
                    Text("2")
                        .font(.bold16)
                        .foregroundColor(.mainText)
                        .lineLimit(1)
                    Text("3")
                        .font(.regular14)
                        .foregroundColor(.mainText)
                        .lineLimit(1)
                }
                Spacer(minLength: 0)
            }.padding(.horizontal, 21)
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 21)
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
}
