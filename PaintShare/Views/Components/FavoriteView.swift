//
//  FavoriteView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/23.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var favoriteDataModel:FavoriteDataModel
        
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var inventoryInquiryDataModel: InventoryInquiryDataModel
    
    var body: some View {
        ZStack{
        VStack(spacing:0){
            CommonHeader(title: "お気に入り", showBackButton: true, showHamburgerButton: false,onBackClick: {
                presentationMode.wrappedValue.dismiss()
            })
            
            RefreshableScrollView(onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    favoriteDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
                    done()
                }
            })
            
            {
                VStack(spacing:0) {
                    ForEach(favoriteDataModel.favoriteListItems,id: \.self){
                        favoriteList in
                        FavoriteItem(favoriteListItem: favoriteList)
                            .onTapGesture {
                                if favoriteList.paintLikeDto.paintDto.deletedFromSearch == 1 {
                                    favoriteDataModel.paintId = favoriteList.paintLikeDto.paintDto.id
                                    inventoryInquiryDataModel.showPaintFavoriteDeletedDialog = true
                                }else{
                                favoriteDataModel.reset()
                                inventoryInquiryDataModel.initData(id: favoriteList.paintLikeDto.paintDto.id, dialogsDataModel: dialogsDataModel)
                                favoriteDataModel.navigationTag = 1
                                }
                            }
                    }
                    //---------- page ----------
                    if(favoriteDataModel.count > favoriteDataModel.favoriteListItems.count){
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
                                   favoriteDataModel.loadMore(dialogsDataModel: dialogsDataModel)
                                })
                        }
                        .padding(.top,20)
                        .padding(.bottom, 40)
                    }
                    //----------------------
                }
                .padding(.top,10)
                
            }
            NavigationLink(
                destination: InventoryInquiry(from:2,fromMenu: true), tag: 1, selection: $favoriteDataModel.navigationTag) {
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
            favoriteDataModel.searchFromZeroPage( dialogsDataModel: dialogsDataModel)
        })
    }
}
