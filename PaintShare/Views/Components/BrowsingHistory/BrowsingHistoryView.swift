//
//  browsingHistoryView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/23.
//

import SwiftUI

struct BrowsingHistoryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var browsingHistoryDataModel:BrowsingHistoryDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var inventoryInquiryDataModel: InventoryInquiryDataModel
    
    var body: some View {
        ZStack{
        VStack(spacing:0){
            CommonHeader(title: "閲覧履歴", showBackButton: true, showHamburgerButton: false,onBackClick: {
                presentationMode.wrappedValue.dismiss()
            })
            
            RefreshableScrollView(onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    browsingHistoryDataModel.searchFromZeroPage( dialogsDataModel: dialogsDataModel)
                    done()
                }
            })
            {
                VStack(spacing:0){
                    ForEach(browsingHistoryDataModel.browsingHistoryListItems,id: \.self){
                        browsingHistoryList in
                        BrowsingHistoryItem(browsingHistoryListItem: browsingHistoryList)
                            .onTapGesture {
                                if browsingHistoryList.paintViewDto.paintDto.deletedFromSearch == 1 {
                                    inventoryInquiryDataModel.showPaintDeletedDialog = true
                                }else{
                                browsingHistoryDataModel.reset()
                                inventoryInquiryDataModel.initData(id: browsingHistoryList.paintViewDto.paintDto.id, dialogsDataModel: dialogsDataModel)
                                browsingHistoryDataModel.navigationTag = 1
                                }
                            }
                    }
                    //---------- page ----------
                    if(browsingHistoryDataModel.count > browsingHistoryDataModel.browsingHistoryListItems.count){
                        HStack {
                            HStack(spacing:3) {
                                Text("もっと見る")
                                    .font(.regular18)
                                    .foregroundColor(Color(hex:"#56B8C4"))
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color(hex:"#56B8C4"))
                            }
                                    .frame(width: UIScreen.main.bounds.size.width - 40,height: 40)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color(hex:"#56B8C4"), lineWidth: 1)
                                    )
                                    .onTapGesture(perform: {
                                        browsingHistoryDataModel.loadMore(dialogsDataModel: dialogsDataModel)
                                })
                        }
                        .padding(.top,20)
                        .padding(.bottom, 40)
                    }
                    //----------------------
                }
                .padding(.top,30)
                
            }
            NavigationLink(
                destination: InventoryInquiry(from:2,fromMenu: true), tag: 1, selection: $browsingHistoryDataModel.navigationTag) {
                    EmptyView()
                }.isDetailLink(false)
            
        }
            MainViewModals()
            if (dialogsDataModel.showLoading) {
                ProgressView()
            }
    }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            browsingHistoryDataModel.searchFromZeroPage( dialogsDataModel: dialogsDataModel)
        })
    }
}
