//
//  InventoryApprovalChange.swift
//  PaintShare
//
//  Created by Lee on 2022/6/21.
//

import SwiftUI

struct InventoryApprovalChange: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inventoryApprovalChangeDataModel: InventoryApprovalChangeDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    var body: some View {
        VStack(spacing: 0){
            CommonHeader(title: "ワークフロー管理", showBackButton: true, showHamburgerButton:false, onBackClick: {
                inventoryApprovalChangeDataModel.changeApproveStatus(dialogsDataModel: dialogsDataModel, mainViewDataModel: mainViewDataModel)
                inventoryApprovalChangeDataModel.navigationTag = nil
                self.presentationMode.wrappedValue.dismiss()
            })
            Toggle(isOn: $mainViewDataModel.groupApproveStatusPermit, label: {
                HStack(spacing: 15) {
                    Text("登録する在庫の承認を行う")
                        .font(.bold16)
                        .foregroundColor(.mainText)
                }
            }).onTapGesture(perform: {
                
            })
            .padding(.top, 20)
            .padding(.bottom, 20)
            .underlineTextField()
            .padding(.horizontal, 21)
            Text("OFFの場合はグループオーナーの承認なしで在庫登録ができます。承認をしてからの登録を行いたい場合はONにしてください。")
                .font(.regular12)
                .foregroundColor(.subText)
                .padding(.top, 20)
                .padding(.horizontal, 21)
            Spacer()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}
