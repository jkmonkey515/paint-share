//
//  OrderHistoryView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/24.
//

import SwiftUI

struct OrderHistoryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var orderHistoryDataModel: OrderHistoryDataModel
    
    @EnvironmentObject var orderDetailsDataModel :OrderDetailsDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var body: some View {
        NavigationView {
            VStack(spacing:0){
                CommonHeader(title: "オーダー履歴一覧", showBackButton: true, showHamburgerButton: false,onBackClick: {
                    presentationMode.wrappedValue.dismiss()
                })
                ScrollView {
                    VStack(spacing:0) {
                        ForEach(orderHistoryDataModel.orderList){
                            item in
                            OrderHistoryItem(orderListItem: item)
                                .padding(.top,20)
                                .onTapGesture {
                                    orderHistoryDataModel.navigationTag = 1
                                    orderDetailsDataModel.initData(item: item, dialogsDataModel: dialogsDataModel)
                                }
                        }
                    }
                }
                
                NavigationLink(
                    destination: OrderDetailsView(), tag: 1, selection: $orderHistoryDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                
            }
            .background(Color(hex: "#F1F1F1"))
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            
        }.navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            .onAppear(perform: {
                orderHistoryDataModel.getListData(dialogsDataModel: dialogsDataModel)
            })
    }
}
