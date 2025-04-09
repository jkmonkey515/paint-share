//
//  DeliveryInformation.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/24.
//

import SwiftUI

struct DeliveryInformation: View {
    
    @EnvironmentObject var orderDetailsDataModel :OrderDetailsDataModel
    
    var body: some View {
        VStack(spacing:0){
            HStack(spacing:0) {
                Text("受け渡し情報")
                    .font(.medium16)
                    .foregroundColor(Color(hex: "#46747E"))
                Spacer()
            }
            
            HStack (spacing:0){
                VStack{
                    Rectangle()
                        .fill(Color(hex: orderDetailsDataModel.deliveryStatus != 2 ?"#707070":"#56B8C4"))//?#707070":"#56B8C4"
                        .frame(width:145,height:3)
                    Text(" ")
                        .font(.regular16)
                }.frame(width: 60)
                
                VStack{
                    Circle()
                        .fill(Color(hex: "#56B8C4"))// ?#707070":"#56B8C4"
                        .frame(width: 16, height: 16)
                        .padding(.leading,0)
                    Text("未済")
                        .font(.regular16)
                        .foregroundColor(Color(hex: orderDetailsDataModel.deliveryStatus != 2 ?"#56B8C4":"#707070"))
                }.frame(width: 70)
                    .padding(.leading,-130.5)
                
                VStack{
                    Circle()
                        .fill(Color(hex: orderDetailsDataModel.deliveryStatus != 2 ?"#707070":"#56B8C4"))//?#707070":"#56B8C4"
                        .frame(width: 16, height: 16)
                    Text("受け渡し済み")
                        .font(.regular16)
                        .foregroundColor(Color(hex: orderDetailsDataModel.deliveryStatus != 2 ?"#707070":"#56B8C4"))//?#707070":"#56B8C4"
                }.frame(width: 100)
            }
            .padding(.leading,70)
            .padding(.top,10)
        }
        .frame(width:UIScreen.main.bounds.size.width - 40)
    }
}
