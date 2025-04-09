//
//  TradedGroup.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/24.
//

import SwiftUI

struct TradedGroup: View {
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var orderDetailsDataModel :OrderDetailsDataModel
    
    var body: some View {
        HStack {
            VStack(spacing: 10)  {
                
                HStack {
                    Text("取引したグループ")
                        .font(.medium16)
                        .foregroundColor(Color(hex: "#46747E"))
                    Spacer()
                }
                
                HStack(spacing: 10) {
                    ZStack {
                        ImageView(withURL: orderDetailsDataModel.profileImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + orderDetailsDataModel.profileImgKey!, onClick: {
                            img in
                        }).frame(width:68,height:68)
                            .clipped()
                    }
                    
                    HStack {
                        VStack(alignment: .leading,spacing: 0) {
                            HStack(spacing:0) {
                                Text("ID :")
                                    .font(.regular12)
                                    .foregroundColor(.mainText)
                                
                                Text(orderDetailsDataModel.generatedUserId)
                                    .font(.regular12)
                                    .foregroundColor(.mainText)
                            }
                            
                            Text(orderDetailsDataModel.groupName)
                                .font(.bold16)
                                .foregroundColor(.mainText)
                            
                            Spacer()
                            HStack{
                                RankCountsLabel(rank0Count: 2, rank1Count: 0, rank2Count: 0, imageSize: 20, font: .regular14, textWidth: 15)
                            }
                        }
                        Spacer(minLength: 0)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 68)
                    .padding(.leading,10)
                }
                .padding(.leading, 20)
                .padding(.trailing, 16)
            }
        }
        .frame(width:UIScreen.main.bounds.size.width - 40,height: 120)
        .contentShape(Rectangle())
        .onAppear(perform: {
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
        })
    }
}
