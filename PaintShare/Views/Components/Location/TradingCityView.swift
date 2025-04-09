//
//  TradingCityView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/02.
//

import SwiftUI

struct TradingCityView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var tradingLocationDataModel:TradingLocationDataModel
    
    var body: some View {

            ZStack{
                Color(hex: "#F1F1F1")
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    List{
                        ForEach(tradingLocationDataModel.selectionPrefecture?.cities ?? [],id:\.self){ machi in
                            HStack{
                                TradingLocationListTitle(title: machi.name, tag: 2, type: 3, code: machi.code)
                                    .onTapGesture {
                                        tradingLocationDataModel.selectionCitiesName = machi.name
                                        tradingLocationDataModel.selectedMenuTab = 0
                                    }
                                Spacer()
                            }
                            .padding(.leading)
                        }
                    }
                    .listStyle(.plain)
                }
                .padding(.bottom)
                
                //head shadow
                VStack {
                    Rectangle()
                        .fill(Color(hex: "#F1F1F1"))
                        .frame(height: 1)
                        .shadow(color: Color(hex: "000000").opacity(0.1), radius: 1, x: 0.0, y: 1)
                        .padding(.bottom)
                    Spacer()
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)

    }
}
