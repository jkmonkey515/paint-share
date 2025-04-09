//
//  InquiryManagement.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/08/24.
//

import SwiftUI

struct InquiryManagement: View {
     @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inquiryListDataModel:InquiryListDataModel
    
    @EnvironmentObject var chatDataModel:ChatDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var inquiryManagementDataModel:InquiryManagementDataModel
    
    @EnvironmentObject var inquiryUserDataModel:InquiryUserDataModel
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    var body: some View {
        VStack(spacing:1){
            CommonHeader(title: "問い合わせ一覧", showBackButton: true, showHamburgerButton: false,onBackClick: {
                 presentationMode.wrappedValue.dismiss()
            })
            if (mainViewDataModel.loggedInUserGroup == nil) {
                Text("データがありません。")
                    .font(.regular14)
                    .foregroundColor(.mainText)
                    .padding(.top, 20)
            }
            //
            if (mainViewDataModel.loggedInUserGroup != nil){
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 37)
                    .shadow(color: Color(hex: "#000000").opacity(0.1), radius: 1, x: 0.0, y: 2)
                
                
                HStack(spacing:0){
                    
                    GeneralButton(onClick: {
                        inquiryManagementDataModel.selectionSwitchTab = 0
                        
                    }, label: {
                        Text("自分の在庫")
                            .font(.regular14)
                        //  .foregroundColor(Color.white)
                            .foregroundColor(inquiryManagementDataModel.selectionSwitchTab == 0 ? .white : Color(hex:"56B8C4"))
                            .frame(width: 148,height: 25)
                    })
                    //.background(Color(hex:"56B8C4"))
                        .background(inquiryManagementDataModel.selectionSwitchTab == 0 ? Color(hex:"56B8C4") : Color.white)
                        .cornerRadius(5)
                    
                    GeneralButton(onClick: {
                        inquiryManagementDataModel.selectionSwitchTab = 1
                    }, label: {
                        Text("他者の商品")
                            .font(.regular14)

                            .foregroundColor(inquiryManagementDataModel.selectionSwitchTab == 0 ? Color(hex:"56B8C4") : Color.white)
                            .frame(width: 148,height: 25)
                    })
                        .background(inquiryManagementDataModel.selectionSwitchTab == 0 ? .white : Color(hex:"56B8C4"))
                        .cornerRadius(5)
                        .padding(.leading,40)
                }
                }
            }//
            
            if(inquiryManagementDataModel.selectionSwitchTab == 0){
                InquiryManagementView()
            } else if (inquiryManagementDataModel.selectionSwitchTab == 1) {
                InquiryListView()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        
    }
}
