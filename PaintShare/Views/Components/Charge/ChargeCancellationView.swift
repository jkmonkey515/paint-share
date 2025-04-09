//
//  ChargeCancellationView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/08/04.
//

import SwiftUI

struct ChargeCancellationView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var chargeCancellationDataModel:ChargeCancellationDataModel
    
    @EnvironmentObject var chargeDataModel:ChargeDataModel
    
    @Binding var showModal: Bool
    
    var body: some View {
//        ZStack {
//            Rectangle()
//                .foregroundColor(Color(hex:"#707070").opacity(0.5))
//
            ZStack {
                
                Rectangle()
                    .foregroundColor(Color.white)
                
                VStack{
                    Spacer()
                    Text("解約手続きを行いますか？")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color(hex: "#56B8C4"))
                        .padding(.bottom,1)
                    
                    HStack(spacing:0) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(Color.yellow)
                            .padding(.bottom)
                        Text("ご契約期間満了日（\(DateTimeUtils.timestampToStrFormat(timestamp: chargeCancellationDataModel.endtime)) ）までご利用いただけます。なお解約申請の取消しはできません。")
                            .font(.regular11)
                            .frame(width: UIScreen.main.bounds.size.width - 120)
                            .foregroundColor(Color(hex: "#707070"))
                    }
                    .padding(.top,5)
                    
                    VStack {
                        Spacer()
                        Text("Paint Links")
                            .font(.bold40)
                            .foregroundColor(Color(hex: "#545353"))
                            .frame(height: 55)
                        
                        Text("月額")
                            .font(.regular20)
                            .foregroundColor(Color(hex: "#D7BE74"))
                            .frame( height: 20)
                            .padding(.top,10)
                        
                        Text("￥250")
                            .font(.regular40)
                            .foregroundColor(Color(hex: "#D7BE74"))
                            .frame(height: 40)
                        
                        
                        Text("購入済み")
                            .font(.regular20)
                            .foregroundColor(Color.white)
                            .frame(width: 170, height: 36)
                            .background(Color(hex: "#46747E").opacity(0.35))
                            .cornerRadius(20)
                            .padding(.top,15)
                        
                        Text("解約")
                            .font(.regular20)
                            .foregroundColor(Color.white)
                            .frame(width: 170, height: 36)
                            .background(Color(hex: "##56B8C4"))
                            .cornerRadius(20)
                            .shadow(color: Color(hex: "000000").opacity(0.16), radius: 3, x: 0.0, y: 3)
                            .onTapGesture {
                                
                                chargeCancellationDataModel.showUnsubscribeDialog = true
                           // chargeCancellationDataModel.cancellingSubscriptions(dialogsDataModel: dialogsDataModel)
                        }
                        
                        Text("閉じる")
                            .font(.regular14)
                            .foregroundColor(Color(hex: "#56B8C4"))
                            .frame(width: 50)
                            .padding(.top,5)
                            .onTapGesture {
                                dialogsDataModel.showChargeCancellationView = false
                            }
                        Spacer()
                    }
                    .frame(width:260,height: 260*1.3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(hex:"#D7BE74"), lineWidth: 4)
                    )
                    .padding(.top,10)
                    .padding(.bottom)
                    Spacer()
                }
                
                
            }
            .background(Color.white)
            .frame(width: 340,height: 340*1.5)
            .cornerRadius(8)
            
    }
}

//struct ChargeCancellationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChargeCancellationView()
//    }
//}
