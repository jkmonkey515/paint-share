//
//  ConfirmCreditCardInformationView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/07/04.
//

import SwiftUI

struct ConfirmCreditCardInformationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inputCreditCardInformationDataModel:InputCreditCardInformationDataModel
    
    @EnvironmentObject var creditCardManagementDataModel:CreditCardManagementDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @State private var check = false

    @EnvironmentObject var orderConfirmDataModel:OrderConfirmDataModel
    
    @EnvironmentObject var paymentResultsDataModel:PaymentResultsDataModel
   
    @EnvironmentObject var chargeDataModel:ChargeDataModel
    
    var body: some View {
        ZStack {
            VStack(spacing:40){
                
                CommonHeader(title: "入力内容の確認", showBackButton: true, showHamburgerButton: false,onBackClick: {
                    presentationMode.wrappedValue.dismiss()
                })
//                    Text("入力内容の確認")
//                        .font(.bold27)
//                        .foregroundColor(Color(hex: "#46747E"))
//                        .padding(.top,10)
                    
                    VStack(spacing:40){
                    ConfirmItem(label: "カード名義人", value: inputCreditCardInformationDataModel.cardName)
                        ConfirmItem(label: "カード番号", value: inputCreditCardInformationDataModel.cardNumber)
                        
                        VStack (spacing:0){
                            HStack(spacing:0) {
                                Text("カード有効期限")
                                    .font(.regular12)
                                    .foregroundColor(.mainText)
                                Spacer()
                            }
                            HStack(spacing:0) {
                                ConfirmItem(label: "", value: inputCreditCardInformationDataModel.cardValidityMonth)
                                    .frame(width: 35)
                                Text("/   ")
                                    .font(.regular16)
                                    .foregroundColor(Color(hex: "#545353"))
                                ConfirmItem(label: "", value: inputCreditCardInformationDataModel.cardValidityYear)
                                    .frame(width: 80)
                                    
                                Spacer()
                            }
                    }
                        
                        ConfirmItem(label: "セキュリティコード", value: inputCreditCardInformationDataModel.securityCode)
                    
                }.frame(width:UIScreen.main.bounds.size.width - 80)
                    .padding(.top,20)
                    
//                    HStack(spacing:10) {
//                        Image(systemName: check
//                              ? "checkmark.square.fill" : "square"
//                                   )
//                            .renderingMode(.template)
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                            .foregroundColor(Color(hex: check ? "56B8C4" : "B2B2B2"))
//                            .onTapGesture {
//                                check.toggle()
//                            }
//                            .padding(.top,0)
//
//                        HStack(spacing:0) {
//                        Text("利用規約")
//                            .font(.regular14)
//                            .foregroundColor(Color(hex: "#56B8C4"))
//                            //. onTapGesture {
//                            //
//                            // }
//                        + Text ("と")
//                            .font(.regular14)
//                            .foregroundColor(Color(hex: "#8E8E8E"))
//                        + Text("プライバシーポリシー")
//                            .font(.regular14)
//                            .foregroundColor(Color(hex: "#56B8C4"))
//                            //. onTapGesture {
//                            //
//                            // }
//                        + Text ("に同意した上で チェックしてください。")
//                            .font(.regular14)
//                            .foregroundColor(Color(hex: "#8E8E8E"))
//
//                    }
//                    }
//                    .frame(width:UIScreen.main.bounds.size.width - 40)
//                    .padding(.leading,0)
//                    .padding(.top,20)
                    Spacer()
                VStack(spacing:30){
                    CommonButton(text: "カードを登録する",width: UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                        if(creditCardManagementDataModel.navigationTag == 1){
                            inputCreditCardInformationDataModel.editCard(dialogsDataModel: dialogsDataModel,orderConfirmDataModel: orderConfirmDataModel,paymentResultsDataModel:paymentResultsDataModel,chargeDataModel:chargeDataModel)
                        }else{
                        inputCreditCardInformationDataModel.createCard(dialogsDataModel: dialogsDataModel,orderConfirmDataModel: orderConfirmDataModel,paymentResultsDataModel:paymentResultsDataModel,chargeDataModel:chargeDataModel)
                        }
                    })
                    
                    CommonButton(text: "戻る", color: Color.caution, width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                        presentationMode.wrappedValue.dismiss()
                    })
                }
                    .padding(.bottom,60)
                
                NavigationLink(
                    destination: PaymentResultsView(), tag: 1, selection: $inputCreditCardInformationDataModel.confirmNavigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                
                
                }
                .foregroundColor(Color.white)
                .navigationBarTitle("")
                .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            
            if (inputCreditCardInformationDataModel.showSaveCardStatus == true ){
                ZStack{
                Color(hex: "707070").opacity(0.30).edgesIgnoringSafeArea(.all)
                    
                Text("登録中...")
                    .foregroundColor(Color.white)
                    .font(.bold40)
                }
                //.opacity(inputCreditCardInformationDataModel.showSaveCardStatus ? 1.0:0.0)
            }
            if inputCreditCardInformationDataModel.fromMenu != false || orderConfirmDataModel.fromMenu != false {
            MainViewModals()
                if (dialogsDataModel.showLoading) {
                    ProgressView()
                }
            }
        }
    }
}

struct ConfirmItem: View {
    var label: String
    var value: String
   
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 15) {
                        Text(label)
                            .font(.regular12)
                            .foregroundColor(.mainText)
                    }
                        Text(value)
                        .padding(.bottom, 2)
                        .font(.medium20)
                        .foregroundColor(Color(hex: "#46747E"))
            }
            Spacer()
        }
    }
}
