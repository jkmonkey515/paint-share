//
//  InventoryApproval.swift
//  PaintShare
//
//  Created by Lee on 2022/6/21.
//

import SwiftUI

struct InventoryApproval: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inventoryApprovalDataModel: InventoryApprovalDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var body: some View {
        VStack(spacing: 0){
            CommonHeader(title: "在庫承認リスト", showBackButton: true, showHamburgerButton:false, onBackClick: {
                inventoryApprovalDataModel.navigationTag = nil
                self.presentationMode.wrappedValue.dismiss()
            })
            HStack {
                Text("リクエスト： \(inventoryApprovalDataModel.resultCount) 件")
                    .font(.regular12)
                    .foregroundColor(.mainText)
                    .padding(.leading, 17)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                Spacer()
            }
            RefreshableScrollView(onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    inventoryApprovalDataModel.getListData(dialogsDataModel: dialogsDataModel)
                    done()
                }
            }) {
                VStack {
                    ForEach(inventoryApprovalDataModel.approvalListItems) {
                        item in
                        ApprovalItem(approvalListItem: item)
                            .underlineListItem()
                    }
                }
            }
            Spacer()
        }
        .modal(isPresented: $inventoryApprovalDataModel.showApprove) {
            ConfirmModal(showModal: $inventoryApprovalDataModel.showApprove, text: "この申請を承認しますか？") {
                inventoryApprovalDataModel.approve(dialogsDataModel: dialogsDataModel)
            }
        }
        .modal(isPresented: $inventoryApprovalDataModel.showDelete) {
            ConfirmModal(showModal: $inventoryApprovalDataModel.showDelete, text: "この申請を削除しますか？") {
                inventoryApprovalDataModel.delete(dialogsDataModel: dialogsDataModel)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
            inventoryApprovalDataModel.getListData(dialogsDataModel: dialogsDataModel)
        })
    }
}
