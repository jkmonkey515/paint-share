//
//  CreditCardManagementView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/07/27.
//

import SwiftUI

struct CreditCardManagementView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inputCreditCardInformationDataModel:InputCreditCardInformationDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var creditCardManagementDataModel: CreditCardManagementDataModel
    
    @EnvironmentObject var hamburgerMenuDataModel:HamburgerMenuDataModel
    
    @EnvironmentObject var chargeDataModel: ChargeDataModel
    
    var body: some View {
        ZStack {
            VStack(spacing:30){
                CommonHeader(title: "カード情報", showBackButton: true, showHamburgerButton: false,onBackClick: {
                    presentationMode.wrappedValue.dismiss()
                })
                
                HStack {
                        VStack {
                            HStack {
                                Text(inputCreditCardInformationDataModel.getBrand)
                                    .font(.bold20)
                                    .foregroundColor(Color(hex: "#707070"))
                                    .shadow(color: .white, radius: 0, x: 1, y: 1)
                                
                                Spacer()
                            }
                            .padding(.leading,5)
                            Spacer()
                            HStack {
                                Spacer()
                                Text(inputCreditCardInformationDataModel.getLast4)
                                    .font(.bold16)
                                    .foregroundColor(Color(hex: "#707070"))
                            }
                            .padding(.bottom,5)
                            
                            HStack {
                                Spacer()
                                Text(inputCreditCardInformationDataModel.getCardName)
                                    .font(.bold16)
                                    .foregroundColor(Color(hex: "#707070"))
                            }
                            .padding(.bottom,5)
                        }
                        .padding(15)
                }
           .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "#A7FCFF"), Color(hex:"#C9FFE6")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
                .frame(width: 125*2.2,height: 88*2.2)
                .shadow(color: Color(hex: "000000").opacity(0.16), radius: 6, x: 0.0, y: 3)
                
                CommonButton(text: "編集する",width: UIScreen.main.bounds.size.width - 40, height: 37,onClick: {
                    inputCreditCardInformationDataModel.cardName = ""
                                            inputCreditCardInformationDataModel.cardNumber = ""
                                            inputCreditCardInformationDataModel.cardValidityYear = ""
                                            inputCreditCardInformationDataModel.cardValidityMonth = ""
                                            inputCreditCardInformationDataModel.securityCode = ""
                                            creditCardManagementDataModel.navigationTag = 1
                })
                    .padding(.top,20)
                
                Spacer()
                
                NavigationLink(
                    destination: InputCreditCardInformationView(), tag: 1, selection: $creditCardManagementDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            .onAppear(perform: {
                hamburgerMenuDataModel.show = false
                inputCreditCardInformationDataModel.getCardList(dialogsDataModel: dialogsDataModel,hamburgerMenuDataModel:hamburgerMenuDataModel)
            })
            MainViewModals()
            if (dialogsDataModel.showLoading) {
                ProgressView()
            }
        }
    }
}
