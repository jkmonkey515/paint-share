//
//  OrderHistoryItem.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/24.
//

import SwiftUI

struct OrderHistoryItem: View {
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var orderListItem: OrderListItem
    
    var body: some View {
        HStack (spacing:0){
            VStack(spacing:0) {
                //------------------------------------------------------------
                VStack(spacing:0){
                    ImageView(withURL: orderListItem.order.materialImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + orderListItem.order.materialImgKey!, onClick: {
                        img in
                    }).frame(width: 94, height: 94)
                        .clipped()
                        .padding(.top,7)
                    
                    ZStack {
                        HStack {
                            Text("商品名")
                                .font(.regular14)
                                .foregroundColor(Color(hex: "#707070"))
                                .padding(.leading,15)
                            Spacer()
                            
                        }
                        HStack{
                            Text(orderListItem.order.paintName)
                                .font(.medium18)
                                .foregroundColor(Color(hex: "#707070"))
                            Spacer()
                        }
                        .padding(.leading, 75)
                        .padding(.trailing, 10)
                    }
                    .padding(.top,3)
                    
                    Rectangle()
                        .fill(Color(hex: "#7070704D"))
                        .frame(height: 1)
                        .padding(.bottom,0)
                    
                }
                .frame(height:130)
                .padding(.top,0)
                //------------------------------------------------------------
                VStack(spacing:0) {
                    Spacer()
                    HStack(spacing:0) {
                        VStack {
                            HStack {
                                Text("注文日時")
                                    .font(.regular14)
                                    .foregroundColor(Color(hex: "#707070"))
                                Spacer()
                            }
                            
                            HStack {
                                Text("注文者")
                                    .font(.regular14)
                                    .foregroundColor(Color(hex: "#707070"))
                                Spacer()
                            }
                            
                            HStack {
                                Text("数量")
                                    .font(.regular14)
                                    .foregroundColor(Color(hex: "#707070"))
                                Spacer()
                            }
                            
                        }
                        .frame(width: 80)
                        .padding(.leading,15)
                        
                        VStack {
                            HStack {
                                Text(orderListItem.order.expirationDate ?? "")
                                    .font(.regular14)
                                    .foregroundColor(Color(hex: "#707070"))
                                Spacer()
                            }
                            
                            HStack {
                                Text("\(orderListItem.user.lastName)    \(orderListItem.user.firstName)")
                                    .font(.regular14)
                                    .foregroundColor(Color(hex: "#707070"))
                                Spacer()
                            }
                            
                            HStack {
                                Text("1個")
                                    .font(.regular14)
                                    .foregroundColor(Color(hex: "#707070"))
                                Spacer()
                            }
                            
                        }
                        .padding(.leading,0)
                        Spacer()
                    }
                    Spacer()
                    Rectangle()
                        .fill(Color(hex: "#7070704D"))
                        .frame(height: 1)
                        .padding(.bottom,0)
                }
                .frame(height:80)
                .padding(.top,0)
                //------------------------------------------------------------
                VStack (spacing:0){
                    Spacer()
                    HStack(spacing:0) {
                        VStack {
                            HStack {
                                Text("注文ステータス")
                                    .font(.regular14)
                                    .foregroundColor(Color(hex: "#707070"))
                                Spacer()
                            }
                            
                            HStack {
                                Text("配送ステータス")
                                    .font(.regular14)
                                    .foregroundColor(Color(hex: "#707070"))
                                Spacer()
                            }
                            
                        }
                        .frame(width: 120)
                        .padding(.leading,15)
                        
                        VStack {
                            HStack {
                                Text(orderListItem.paymentStatus == 0 ? "未払い" : "お支払い完了")
                                    .font(.regular14)
                                    .foregroundColor(Color(hex: "#46747E"))
                                Spacer()
                            }
                            
                            HStack {
                                Text(orderListItem.deliveryStatus != 2 ? "未発送" : "発送済み")
                                    .font(.regular14)
                                    .foregroundColor(Color(hex: "#46747E"))
                                Spacer()
                            }
                            
                        }
                        .padding(.leading,0)
                        Spacer()
                    }
                    Spacer()
                    Rectangle()
                        .fill(Color(hex: "#7070704D"))
                        .frame(height: 1)
                        .padding(.bottom,0)
                }
                .frame(height:50)
                //------------------------------------------------------------
            }
            .frame(width:UIScreen.main.bounds.size.width - 72,height: 260)
            ZStack{
                Image(systemName: "chevron.right")
                    .frame(height: 16)
                    .foregroundColor(Color.white)
            }
            .frame(width: 32,height: 260 )
            .background(Color(hex: "#DCCC3D"))
            .padding(.trailing,0)
        }
        .frame(width:UIScreen.main.bounds.size.width - 40,height: 260)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(color: Color(hex: "000000").opacity(0.1), radius: 3, x: -2, y: 4)
        .onAppear(perform: {
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
        })
    }
}
