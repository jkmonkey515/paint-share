//
//  TradingLocationListTitle.swift
//  PaintShare
//
//  Created by  Kaetsu Jo on 2022/06/01.
//

import SwiftUI

struct LocationMenuListTitle: View {
    
    @EnvironmentObject var tradingLocationDataModel:TradingLocationDataModel
    
    var title : String
    
    var place :String
    
    var tag: Int
    
    @Binding var selectedMenuTab: Int
    
    var body: some View {
        HStack {
            Text(self.title)
                .font(.regular16)
                .foregroundColor(Color(hex: tag != 2||tradingLocationDataModel.selectionPrefecture != nil ? "#545353" :"#E0E0E0"))
                .frame( height: 32)
            
            Spacer()
            
            //place
            Text(self.place)
                .font(.regular14)
                .foregroundColor(Color(hex:"#545353"))
                .padding(.trailing,5)
            //button
            Image(systemName: "chevron.right")
                .font(Font.system(size: 18, weight: .regular))
                .padding(.trailing,0)
        }
        .contentShape(Rectangle())
        .onTapGesture{
            if (tag != 2 || tradingLocationDataModel.selectionPrefecture != nil){
                selectedMenuTab = tag
            }
        }
        .padding(.leading,0)
    }
}
