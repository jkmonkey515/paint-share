//
//  ChargeView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/07/04.
//

import SwiftUI

struct ChargeView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var chargeDataModel:ChargeDataModel
    
    @EnvironmentObject var paymentResultsDataModel:PaymentResultsDataModel
    
    @EnvironmentObject var inputCreditCardInformationDataModel:InputCreditCardInformationDataModel
    
    @EnvironmentObject var orderConfirmDataModel:OrderConfirmDataModel
    
    
    @Binding var showModal: Bool
    
    var body: some View {
            ZStack {
//                Rectangle()
//                            .foregroundColor(Color(hex:"#707070").opacity(0))
                
                Image("charge-ad")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack{
                   Spacer()
                    
                    Image("charge-bottun")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.size.width - 160)
                        .onTapGesture {
                            //getlist
                            if chargeDataModel.showSubStatus == false {
                                chargeDataModel.purchaseSubscription(dialogsDataModel: dialogsDataModel)
//                                chargeDataModel.checkAndCreateSubscription(paymentResultsDataModel: paymentResultsDataModel,dialogsDataModel: dialogsDataModel,inputCreditCardInformationDataModel: inputCreditCardInformationDataModel,orderConfirmDataModel:orderConfirmDataModel)
                            }
                            
                            //chargeDataModel.showPaymentErrorModal = true
                            
                            
                        }
                      
                    Text("閉じる")
                        .font(.regular16)
                        .foregroundColor(Color(hex: "#707070"))
                        .frame(width: 50)
                        .padding(.top,10)
                        .padding(.bottom,(UIScreen.main.bounds.size.width - 50)*1.5/10)
                        .onTapGesture {
                            dialogsDataModel.showChargeView = false
                        }
                }
                
                if chargeDataModel.showSubStatus == true {
                    Text("決済中...")
                        .frame(width: UIScreen.main.bounds.size.width - 50,height: (UIScreen.main.bounds.size.width - 50)*1.5)
                        .foregroundColor(Color.white)
                        .font(.bold16)
                        .background(Color(hex: "707070").opacity(0.30))
                }else{
                            
                }
                    
            }
            .frame(width: UIScreen.main.bounds.size.width - 50,height: (UIScreen.main.bounds.size.width - 50)*1.5)
            .modal(isPresented: $chargeDataModel.showDeviceErrorModal) {
                ErrorModal(showModal: $chargeDataModel.showDeviceErrorModal, text: "このデバイスは対応していません。", onConfirm: {})
            }
            .modal(isPresented: $chargeDataModel.showPaymentErrorModal) {
                ErrorModal(showModal: $chargeDataModel.showPaymentErrorModal, text: "支払いができませんでした。アプリ内課金の支払い方法をご確認ください。", onConfirm: {})
            }
            .modal(isPresented: $chargeDataModel.showOtherErrorModal) {
                ErrorModal(showModal: $chargeDataModel.showOtherErrorModal, text: "問題が発生しました。再度試してみてください。", onConfirm: {})
            }
    }
}
