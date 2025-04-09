//
//  PaymentResultsView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/07/04.
//

import SwiftUI

struct PaymentResultsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    @EnvironmentObject var paymentResultsDataModel:PaymentResultsDataModel
    
    @EnvironmentObject var dialogsDataModel:DialogsDataModel
    
    @EnvironmentObject var chargeDataModel:ChargeDataModel
    
    @EnvironmentObject var accountManagementDataModel: AccountManagementDataModel
    
    @EnvironmentObject var inventoryInquiryDataModel:InventoryInquiryDataModel
    
    @EnvironmentObject var inventorySearchDataModel:InventorySearchDataModel
    
    @EnvironmentObject var inputCreditCardInformationDataModel:InputCreditCardInformationDataModel
    
    @EnvironmentObject var orderConfirmDataModel:OrderConfirmDataModel
    
    @EnvironmentObject var browsingHistoryDataModel:BrowsingHistoryDataModel
    
    @EnvironmentObject var favoriteDataModel:FavoriteDataModel
    
    var body: some View {
            VStack(spacing:40){
                
                //Text("決済成功")
                Text(paymentResultsDataModel.tag == 1 ? "決済成功" : "決済失敗")
                    .font(.bold27)
                    .foregroundColor(Color(hex: "#46747E"))
                    .frame(width: 250,height:50)
                    .padding(8)
                    .background(Color(hex: "#A3E8F1"))
                    .cornerRadius(50)
                
               // Image("appicon-smile")
                Image(paymentResultsDataModel.tag == 1 ? "appicon-smile":"appicon-error")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height:paymentResultsDataModel.tag == 1  ? 160:130)
                
                
                VStack(spacing:5){
                    Text("この度はPaint Linksをご利用いただき。")
                        .font(.medium16)
                        .foregroundColor(Color(hex: "#707070"))
                    
                    Text("誠にありがとうございます")
                        .font(.medium16)
                        .foregroundColor(Color(hex: "#707070"))
                    
                    if(paymentResultsDataModel.tag == 1){
                    Text("引き続きよろしくお願いいたします。")
                        .font(.medium16)
                        .foregroundColor(Color(hex: "#707070"))
                    }else{
                    Text("決済処理を試みましたがエラーが発生した為")
                    .font(.medium16)
                    .foregroundColor(Color(hex: "#707070"))
                    
                    Text("再度ご入力をお願いいたします。")
                    .font(.medium16)
                    .foregroundColor(Color(hex: "#707070"))
                    }
                }
                .padding(.top,15)
                
                if(paymentResultsDataModel.tag == 1 ){
                CommonButton(text: "在庫を検索する",width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                    //dialogsDataModel.showChargeView = false
                    dialogsDataModel.mainViewNavigationTag = nil
                    inventoryInquiryDataModel.navigationTag = nil
                    inventorySearchDataModel.navigationTag = nil
                    browsingHistoryDataModel.navigationTag = nil
                    favoriteDataModel.navigationTag = nil
                    orderConfirmDataModel.navigationTag = nil
                    mainViewDataModel.selectedTab = 1
                })
                    .padding(.top,50)
                }else{
                CommonButton(text: "入力画面へ",width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                   // dialogsDataModel.showChargeView = false
                    if orderConfirmDataModel.fromMenu == true{
                        orderConfirmDataModel.navigationTag = 1
                    }else{
                        dialogsDataModel.mainViewNavigationTag = 17
                    }
                    inputCreditCardInformationDataModel.navigationTag = nil                  
                })
                .padding(.top,40)
                }
                
            }
            .foregroundColor(Color.white)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            .onAppear(perform: {
                dialogsDataModel.showChargeView = false
                accountManagementDataModel.getSubscriptionInformation(dialogsDataModel: dialogsDataModel)
                accountManagementDataModel.getUserInfo(dialogsDataModel: dialogsDataModel)
                debugPrintLog(message:"payment")
            })
    }
}


//struct PaymentResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PaymentResultsView()
//    }
//}
