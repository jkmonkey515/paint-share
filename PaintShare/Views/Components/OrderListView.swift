//
//  OrderListView.swift
//  PaintShare
//
//  Created by Lee on 2022/6/24.
//

import SwiftUI

struct OrderListView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inventoryApprovalDataModel: InventoryApprovalDataModel
    
    @EnvironmentObject var orderListDataModel: OrderListDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var orderRegardDataModel: OrderRegardDataModel
    
    @EnvironmentObject var managerViewDataModel:ManagerViewDataModel
    
    var body: some View {
        ZStack{
        VStack(spacing: 0){
            CommonHeader(title: "注文一覧", showBackButton: true, showHamburgerButton:false, onBackClick: {
                orderListDataModel.navigationTag = nil
                self.presentationMode.wrappedValue.dismiss()
            })
            RefreshableScrollView(onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    orderListDataModel.getListData(dialogsDataModel: dialogsDataModel)
                    done()
                }
            }) {
                VStack {
                    ForEach(orderListDataModel.orderListItems) {
                        item in
                        OrderItem(orderListItem: item)
                            .underlineListItem()
                            .onTapGesture {
                                orderRegardDataModel.initData(item: item, dialogsDataModel: dialogsDataModel)
                                orderRegardDataModel.navigationTag = 1
                            }
                    }
                    NavigationLink(
                        destination: OrderRegardView(), tag: 1, selection: $orderRegardDataModel.navigationTag) {
                            EmptyView()
                        }.isDetailLink(false)
                    NavigationLink(
                        destination: ManagerView(), tag: 1, selection: $orderListDataModel.navigationTag) {
                            EmptyView()
                        }.isDetailLink(false)
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                }
            }
            Spacer()
        }
            OrderListViewModals()
    }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
            orderListDataModel.getListData(dialogsDataModel: dialogsDataModel)
        })
    }
}

struct OrderListViewModals: View {
    
    @EnvironmentObject var orderListDataModel:OrderListDataModel
    
    @EnvironmentObject var managerViewDataModel:ManagerViewDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var body: some View {
        EmptyView()
            .modal(isPresented: $orderListDataModel.showTransferAccountRegistrationDialog) {
                        ConfirmModal(showModal: $orderListDataModel.showTransferAccountRegistrationDialog, text: "振込先情報が未登録です\n入力を行ってください", onConfirm: {
                            orderListDataModel.navigationTag = 1
                            managerViewDataModel.reset()
                            managerViewDataModel.setManagerInfo(dialogsDataModel: dialogsDataModel)
                        })
                    }
        
    }
}
