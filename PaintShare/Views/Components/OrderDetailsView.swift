//
//  OrderDetailsView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/24.
//

import SwiftUI

struct OrderDetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var orderDetailsDataModel :OrderDetailsDataModel
    
    var body: some View {
            VStack(spacing:0){
                CommonHeader(title: "オーダー詳細", showBackButton: true, showHamburgerButton: false,onBackClick: {
                    presentationMode.wrappedValue.dismiss()
                })
                ScrollView {
                    //TradedGroup()
                    
                    GoodsInformation()
                        .padding(.top,20)
                    
                    //PurchaseInformation()
                        //.padding(.top,20)
                    
                    HStack{
                        Text("購入情報")
                            .font(.bold16)
                            .foregroundColor(Color(hex: "#46747E"))
                        Spacer()
                    }
                    .padding(.horizontal, 11)
                    
                    HStack{
                        Text("お引渡し予定日:")
                            .font(.regular14)
                            .foregroundColor(Color(hex: "#707070"))
                        Text(orderDetailsDataModel.arrivalDate == "" ? "準備中" : orderDetailsDataModel.arrivalDate)
                            .font(.medium16)
                            .foregroundColor(Color(hex: "#1DB78B"))
                        Spacer()
                    }
                    .padding(.bottom, 11)
                    .underlineListItem()
                    .padding(.horizontal, 21)
                    
                    Group{
                        VStack{
                            VStack(spacing: 5){
                                HStack{
                                    Text("商品の小計:")
                                        .font(.regular14)
                                        .foregroundColor(Color(hex: "#707070"))
                                    Spacer()
                                    Text(String(format:"￥%.0f",(Float(orderDetailsDataModel.paintPriceNum.filter{$0 != ","}) ?? 0)*(Float(orderDetailsDataModel.paintNum) ?? 0)))
                                        .font(.regular14)
                                        .foregroundColor(Color(hex: "#707070"))
                                }
                                HStack{
                                    Text("合計:")
                                        .font(.regular14)
                                        .foregroundColor(Color(hex: "#707070"))
                                    Spacer()
                                    Text(String(format:"￥%.0f",(Float(orderDetailsDataModel.paintPriceNum.filter{$0 != ","}) ?? 0)*(Float(orderDetailsDataModel.paintNum) ?? 0)))
                                        .font(.regular14)
                                        .foregroundColor(Color(hex: "#707070"))
                                }
                                HStack{
                                    Text("ご請求額:")
                                        .font(.bold20)
                                        .foregroundColor(Color(hex: "#707070"))
                                    Spacer()
                                    Text(String(format:"￥%.0f",(Float(orderDetailsDataModel.paintPriceNum.filter{$0 != ","}) ?? 0)*(Float(orderDetailsDataModel.paintNum) ?? 0)))
                                        .font(.bold20)
                                        .foregroundColor(Color(hex: "#F16161"))
                                }
                            }
                            .padding(.horizontal, 21)
                           
                        }
                    }
                    
                    DeliveryInformation()
                        .padding(.top,20)
                    
                    Spacer(minLength: 50)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            
    }
}
