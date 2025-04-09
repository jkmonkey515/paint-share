//
//  InquiryListView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/20.
//

import SwiftUI

struct InquiryListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inquiryListDataModel:InquiryListDataModel
    
    @EnvironmentObject var chatDataModel:ChatDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var groupDetailInfoDataModel:GroupDetailInfoDataModel
    
    @EnvironmentObject var mainViewDataModel:MainViewDataModel
    
    var body: some View {

            VStack(spacing:0){
//                CommonHeader(title: "問い合わせ一覧", showBackButton: true, showHamburgerButton: false,onBackClick: {
//                    presentationMode.wrappedValue.dismiss()
//                })
                ScrollView{
                VStack(spacing:0) {
                    ForEach(inquiryListDataModel.chatroomListItems,id: \.self){
                        item in
                        InquiryListItem(chatroomListItem: item,numberMark: item.chatroomDto.unreadMessageCount ?? 0)
                            .onTapGesture {
                                chatDataModel.reset()
                                groupDetailInfoDataModel.reset()
                                chatDataModel.paintId = item.chatroomDto.paint.id
                                chatDataModel.chatroomDto = item.chatroomDto
                                chatDataModel.getReviewDto(dialogsDataModel: dialogsDataModel)
                                inquiryListDataModel.navigationTag = 1
                                groupDetailInfoDataModel.groupId = item.chatroomDto.paint.ownedBy.id
                                chatDataModel.groupId = item.chatroomDto.paint.ownedBy.id
                                groupDetailInfoDataModel.getGroupSearchDto(dialogsDataModel: dialogsDataModel, mainViewDataModel: mainViewDataModel)
                                chatDataModel.imgKey=item.chatroomDto.paint.materialImgKey
                           //     AppBadgeNumber.getUnreadMessageCounts()
                            }
                    }
                }.padding(.top,15)
                Spacer()
                NavigationLink(
                    destination: ChatView(), tag: 1, selection: $inquiryListDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            .onAppear(perform: {
                inquiryListDataModel.getLoginUserParticipateChatroomList(dialogsDataModel: dialogsDataModel)
                dialogsDataModel.getUnreadMessageCounts()
                //AppBadgeNumber.getUnreadMessageCounts()
            })
    }
}
