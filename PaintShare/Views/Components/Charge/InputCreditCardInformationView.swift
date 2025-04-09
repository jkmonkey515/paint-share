//
//  InputCreditCardInformationView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/07/04.
//

import SwiftUI

struct InputCreditCardInformationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var inputCreditCardInformationDataModel:InputCreditCardInformationDataModel
    
    @EnvironmentObject var hamburgerMenuDataModel:HamburgerMenuDataModel
    
    var body: some View {
        ZStack {
            VStack(spacing:0){
                CommonHeader(title: "カード情報の入力", showBackButton: true, showHamburgerButton: false,onBackClick: {
                    presentationMode.wrappedValue.dismiss()
                })
                //                Text("カード情報の入力")
                //                    .font(.bold27)
                //                    .foregroundColor(Color(hex: "#46747E"))
                //                    .padding(.top,10)
                ScrollView {
                    VStack(spacing:40){
                        ZStack{
                            Rectangle()
                                .foregroundColor(Color(hex:"#A3E8F1"))
                            VStack(spacing:7) {
                                Spacer()
                                Text("ご利用可能なクレジットカード")
                                    .font(.regular14)
                                    .foregroundColor(Color(hex: "#545353"))
                                
                                HStack(spacing:7) {
                                    Image("credit-card-visa")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 29)
                                    Image("credit-card-master")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 29)
                                    Image("credit-card-jcb")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 29)
                                    Image("credit-card-amex")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 29)
                                    Image("credit-card-diners")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 29)
                                    Image("credit-card-discover")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 29)
                                }
                                Spacer()
                            }
                            
                        }
                        .frame(height: 74)
                        
                        
                        VStack(spacing:38){
                            CommonTextField(label: "カード名義人", placeholder: "Taro Yamada", value: $inputCreditCardInformationDataModel.cardName,validationMessage: inputCreditCardInformationDataModel.cardNameMessage)
                            CommonTextField(label: "カード番号", placeholder: "1234　5678　1234　5678", value:$inputCreditCardInformationDataModel.cardNumber, cardNumberSpace:true,validationMessage: inputCreditCardInformationDataModel.cardNumberMessage)
                            VStack (spacing:0){
                                HStack(spacing:0) {
                                    Text("カード有効期限")
                                        .font(.regular12)
                                        .foregroundColor(.mainText)
                                    Spacer()
                                }
                                HStack(spacing:0) {
                                    CommonTextField(label: "", placeholder: "MM", value: $inputCreditCardInformationDataModel.cardValidityMonth,inputTwoCount: true)
                                        .frame(width: 40)
                                    Text("/")
                                        .font(.regular16)
                                        .foregroundColor(Color(hex: "#545353"))
                                        .padding(.bottom,0)
                                    CommonTextField(label: "", placeholder: "YY", value: $inputCreditCardInformationDataModel.cardValidityYear,inputTwoCount: true)
                                        .frame(width: 40)
                                    Spacer()
                                }
                                
                                if (!inputCreditCardInformationDataModel.cardValidityMessage.isEmpty) {
                                    HStack{
                                        Text(inputCreditCardInformationDataModel.cardValidityMessage)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .lineLimit(nil)
                                            .font(.bold12)
                                            .foregroundColor(.caution)
                                        Spacer()
                                    }.padding(.top,0)
                                }else{
                                    
                                }
                            }
                            HStack {
                                CommonTextField(label: "セキュリティコード", placeholder: "CVC", value: $inputCreditCardInformationDataModel.securityCode,validationMessage: inputCreditCardInformationDataModel.securityCodeMessage)
                                    .frame(width: 140)
                                TooltipLabel()
                                    .padding(.bottom,0)
                                    .onTapGesture(perform: {
                                        inputCreditCardInformationDataModel.tooltipTitle = "セキュリティーコード(cvv/cvc)とは"
                                        inputCreditCardInformationDataModel.tooltipDescription = "セキュリティコードは、カード裏面に印字されている3桁または4桁の数字です。インターネットショッピングの際、セキュリティーを高めるために入力する場合があります。"
                                        inputCreditCardInformationDataModel.tooltipDialog = true
                                    })
                                Spacer()
                            }
                        }
                        .frame(width:UIScreen.main.bounds.size.width - 80)
                        .padding(.bottom,5)
                    }
                    .padding(.top,46)
                    .padding(.bottom, 200)
                }
                Spacer()
                VStack(spacing:30){
                    //                CommonButton(text: "入力内容の確認へ",width: UIScreen.main.bounds.size.width - 40, height: 37,disabled: inputCreditCardInformationDataModel.checkInformation(), onClick: {
                    //                    inputCreditCardInformationDataModel.navigationTag = 1
                    //                })
                    
                    CommonButton(text: "入力内容の確認へ",width: UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                        inputCreditCardInformationDataModel.checkCardInfo()
                    })
                    
                    CommonButton(text: "戻る", color: Color.caution, width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                        presentationMode.wrappedValue.dismiss()
                    })
                    
                }
                .padding(.bottom,60)
                
                NavigationLink(
                    destination: ConfirmCreditCardInformationView(), tag: 1, selection: $inputCreditCardInformationDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                
            }
            .foregroundColor(Color.white)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            .onAppear(perform: {
                dialogsDataModel.showChargeView = false
                hamburgerMenuDataModel.show = false
                inputCreditCardInformationDataModel.confirmNavigationTag = nil
            })
            if inputCreditCardInformationDataModel.fromMenu != false {
                MainViewModals()
                if (dialogsDataModel.showLoading) {
                    ProgressView()
                }
            }
        }
        
    }
}

