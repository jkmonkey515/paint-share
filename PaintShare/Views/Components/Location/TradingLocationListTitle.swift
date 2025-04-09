//
//  TradingLocationListTitle.swift
//  PaintShare
//
//  Created by  Kaetsu Joon 2022/06/02.
//

import SwiftUI

struct TradingLocationListTitle: View {
    @EnvironmentObject var tradingLocationDataModel:TradingLocationDataModel
    
    var title : String
    
    var tag: Int
    
    var type: Int
    
    var code: Int
    
    var body: some View {
        HStack {
            Text(self.title)
                .font(.regular16)
                .foregroundColor(Color(hex:"#545353"))
                .frame( height: 32)

            Spacer()
        }
        .contentShape(Rectangle())
        .padding(.leading,0)
    }
}
