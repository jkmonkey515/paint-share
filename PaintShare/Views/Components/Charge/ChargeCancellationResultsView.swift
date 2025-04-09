//
//  ChargeCancellationResultsView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/08/04.
//

import SwiftUI

struct ChargeCancellationResultsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    @EnvironmentObject var dialogsDataModel:DialogsDataModel
    
    @EnvironmentObject var chargeCancellationDataModel:ChargeCancellationDataModel
    
    @EnvironmentObject var accountManagementDataModel: AccountManagementDataModel
    
    var body: some View {
        VStack(spacing:25){
            
            Image("app-icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)            
            
            VStack(spacing:10){
                Text("解約手続きが完了しました")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    //.font(.bold20)
                    .foregroundColor(Color(hex: "#56B8C4"))
                
                Text("ご利用ありがとうございました")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#56B8C4"))
            }
    
            Text("閉じる")
                .font(.regular14)
                .foregroundColor(Color(hex: "#56B8C4"))
                .frame(width: 50)
                .padding(.top,5)
                .onTapGesture {
                    dialogsDataModel.showChargeCancellationView = false
                    dialogsDataModel.mainViewNavigationTag = nil
                     mainViewDataModel.selectedTab = 1
                }
        }
        .foregroundColor(Color.white)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            accountManagementDataModel.getSubscriptionInformation(dialogsDataModel: dialogsDataModel)
            accountManagementDataModel.getUserInfo(dialogsDataModel: dialogsDataModel)
            debugPrintLog(message:"cancel")
        })
    }
}

//struct ChargeCancellationResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChargeCancellationResultsView()
//    }
//}
