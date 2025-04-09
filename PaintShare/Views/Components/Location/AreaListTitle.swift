//
//  AreaListTitle.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/30/22.
//

import SwiftUI

struct AreaListTitle: View {
    @EnvironmentObject var locationDataModel:LocationDataModel

    var title : String
    
    var tag: Int
    
    var type: Int
    
    var code: Int
    
    var body: some View{
        HStack(spacing:0) {
            if( tag != 0){
                Image(systemName: locationDataModel.checkBoxMap[type]![code]!
                      ? "checkmark.square.fill"
                      : "square")
                    .foregroundColor(Color(hex: locationDataModel.checkBoxMap[type]![code]! ? "56B8C4" : "B2B2B2" ))
                    .onTapGesture {
                        locationDataModel.checkBoxMap[type]![code] = !locationDataModel.checkBoxMap[type]![code]!
                        locationDataModel.printCheck()
                    }
            }
            Text(self.title)
                .font( tag == 0 ? .medium16 : .regular16)
                .foregroundColor(Color(hex:"#545353"))
            
            Spacer()
            
            if(tag == 1){
                Text( locationDataModel.checkBoxMap[type]![code]! ? "全地域選択中":"地域選択中")
                    .font( locationDataModel.checkBoxMap[type]![code]! ? .medium16 : .regular16)
                    .foregroundColor(Color(hex:locationDataModel.checkBoxMap[type]![code]! ? "#545353":"#8E8E8E"))
            }
        }
        .frame( height: tag == 0 ? 40 : 32)
        .padding(.leading,0)
    }
}
