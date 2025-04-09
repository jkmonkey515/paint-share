//
//  OrderPaymentResultsView.swift
//  PaintShare
//
//  Created by Lee on 2022/6/24.
//

import SwiftUI

struct OrderPaymentResultsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var orderConfirmDataModel: OrderConfirmDataModel
    
    @EnvironmentObject var orderWishDataModel: OrderWishDataModel
    
    @EnvironmentObject var orderPaymentResultsDataModel: OrderPaymentResultsDataModel
    
    @EnvironmentObject var chatDataModel: ChatDataModel
    
    @EnvironmentObject var inventoryInquiryDataModel: InventoryInquiryDataModel
    
    @EnvironmentObject var inventorySearchDataModel: InventorySearchDataModel
    
    @EnvironmentObject var browsingHistoryDataModel:BrowsingHistoryDataModel
    
    @EnvironmentObject var favoriteDataModel:FavoriteDataModel
    
    var body: some View {
        VStack(spacing:40){
            
            if dialogsDataModel.orderPayResult == 2{
                
                Text("申込みが完了しました")
                    .font(Font.custom("NotoSansCJKjp-Bold", size: 21))
                    .foregroundColor(Color(hex: "#46747E"))
                
                Image("app-icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height:dialogsDataModel.orderPayResult == 1  ? 160:130)
            }else{
                Text(dialogsDataModel.orderPayResult == 1 ? "ご購入ありがとうございます！" : "購入を完了できませんでした。")
                    .font(.bold20)
                    .foregroundColor(Color(hex: "#46747E"))
                    .frame(width: 330,height:60)
                    .padding(8)
                    .background(Color(hex: "#A3E8F1"))
                    .cornerRadius(60)
                
                Image(dialogsDataModel.orderPayResult == 1 ? "appicon-smile":"appicon-error")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height:dialogsDataModel.orderPayResult == 1  ? 160:130)
            }
            
            if dialogsDataModel.orderPayResult == 1{
                VStack(spacing:5){
                    Text("決済が完了しました。")
                        .font(.medium16)
                        .foregroundColor(Color(hex: "#707070"))
                    
                    Text("チャットページにて引き続きやり取りを")
                        .font(.medium16)
                        .foregroundColor(Color(hex: "#707070"))
                    
                    Text("お願いいたします。")
                        .font(.medium16)
                        .foregroundColor(Color(hex: "#707070"))
                }
                .padding(.top,15)
            }else if dialogsDataModel.orderPayResult == 2{
                VStack(spacing:5){
                    Text("チャットページにて引き続きやり取りを")
                        .font(.medium16)
                        .foregroundColor(Color(hex: "#707070"))
                    
                    Text("お願いいたします。")
                        .font(.medium16)
                        .foregroundColor(Color(hex: "#707070"))
                }
                .padding(.top,15)
            }else{
                VStack(spacing:5){
                    Text("この度はPaint Linksをご利用いただき")
                        .font(.medium16)
                        .foregroundColor(Color(hex: "#707070"))
                    
                    Text("誠にありがとうございます。")
                        .font(.medium16)
                        .foregroundColor(Color(hex: "#707070"))
                    
                    Text("決済処理を試みましたがエラーが発生した為")
                        .font(.medium16)
                        .foregroundColor(Color(hex: "#707070"))
                    
                    Text("再度ご注文をお願いいたします。")
                        .font(.medium16)
                        .foregroundColor(Color(hex: "#707070"))
                }
                .padding(.top,15)
            }
            
            if(dialogsDataModel.orderPayResult == 1){
                CommonButton(text: "チャットページへ",width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                    dialogsDataModel.mainViewNavigationTag = nil//60
                    inventoryInquiryDataModel.navigationTag = nil//10
                    inventorySearchDataModel.navigationTag = nil//2
                    orderConfirmDataModel.navigationTag = nil
                    browsingHistoryDataModel.navigationTag = nil
                    favoriteDataModel.navigationTag = nil
                    chatDataModel.reset()
                    chatDataModel.fromMenu = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        chatDataModel.getExistingChatroom(mainViewDataModel: mainViewDataModel,paintId:inventoryInquiryDataModel.id,dialogsDataModel: dialogsDataModel, chatDataModel:chatDataModel, inventoryInquiryDataModel: inventoryInquiryDataModel,orderConfirmDataModel: orderConfirmDataModel,orderWish: false)
                        chatDataModel.imgKey = inventoryInquiryDataModel.materialImgKey
                    })
                })
                    .padding(.top,50)
            }else if(dialogsDataModel.orderPayResult == 2){
                CommonButton(text: "チャットページへ",width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                    dialogsDataModel.mainViewNavigationTag = nil//60
                    inventoryInquiryDataModel.navigationTag = nil//10
                    inventorySearchDataModel.navigationTag = nil//2
                    orderWishDataModel.navigationTag = nil
                    browsingHistoryDataModel.navigationTag = nil
                    favoriteDataModel.navigationTag = nil
                    chatDataModel.reset()
                    chatDataModel.fromMenu=false
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        chatDataModel.getExistingChatroom(mainViewDataModel: mainViewDataModel,paintId:inventoryInquiryDataModel.id,dialogsDataModel: dialogsDataModel, chatDataModel:chatDataModel, inventoryInquiryDataModel: inventoryInquiryDataModel, orderConfirmDataModel: nil,orderWish: true)
                        chatDataModel.imgKey = inventoryInquiryDataModel.materialImgKey
                    })
                })
                    .padding(.top,50)
            }else{
                CommonButton(text: "注文確認画面へ",width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                      inventoryInquiryDataModel.navigationTag = 10
                    self.presentationMode.wrappedValue.dismiss()
                })
                    .padding(.top,40)
            }
        }
        .foregroundColor(Color.white)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
        })
    }
}
