//
//   InquiryUser.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/20.
//

import SwiftUI

struct InquiryUserView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inquiryManagementDataModel:InquiryManagementDataModel
    
    @EnvironmentObject var inquiryUserDataModel:InquiryUserDataModel
    
    @EnvironmentObject var chatDataModel:ChatDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var body: some View {
            VStack(spacing:0){
                CommonHeader(title: "問い合わせユーザー", showBackButton: true,showHamburgerButton: false, onBackClick: {
                    presentationMode.wrappedValue.dismiss()
                    
                })
                
                VStack (spacing:0){
                    HStack {
                        VStack {
                            HStack(spacing: 10) {
                                ZStack {
                                    ImageView(withURL: inquiryUserDataModel.imgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + inquiryUserDataModel.imgKey!, onClick: {
                                        img in
                                    }).frame(width:68,height:68)
                                        .clipped()
                                   // ReceptionLabel()
                                }

                                HStack {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(inquiryUserDataModel.inventoryDto?.ownedBy.groupName ?? "")//
                                                .font(.regular12)
                                                .foregroundColor(.mainText)
                                        }
                                        Text(inquiryUserDataModel.inventoryDto?.goodsNameName ?? " ")//
                                            .font(.medium16)
                                            .foregroundColor(.mainText)
                                        HStack {
                                            Text(inquiryUserDataModel.inventoryDto?.price != nil ? String(inquiryUserDataModel.inventoryDto!.price!) + "円": " ")
                                                    .font(.regular13)
                                                    .foregroundColor(.mainText)
                                        }
                                    }
                                    Spacer(minLength: 0)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .padding(.leading, 10)
                            .padding(.trailing, 16)
                            }
                        }
                        .padding(.bottom,0)
                    }
                    .frame(height: 100)
                    .contentShape(Rectangle())
                    .padding(.leading,0)
            
                    Rectangle()
                        .fill(Color(hex: "#F1F1F1"))
                        .frame(height: 3)
                ScrollView{
                    VStack(spacing:0){
                        
                        ForEach(inquiryUserDataModel.chatroomUsersListItems,id:\.self){
                            inquiryUser in
                            InquiryUserItem(chatroomUsersListItem: inquiryUser,numberMark: inquiryUser.chatroomDto.unreadMessageCount ?? 0)
                                .onTapGesture {
                                    chatDataModel.reset()
                                    chatDataModel.paintId = inquiryUser.chatroomDto.paint.id
                                    chatDataModel.chatroomDto=inquiryUser.chatroomDto
                                    chatDataModel.imgKey=inquiryUser.chatroomDto.paint.materialImgKey
                                //    AppBadgeNumber.getUnreadMessageCounts()
                                    inquiryUserDataModel.navigationTag = 1
                                }
                        }
                    }
                    .padding(.top,8)
                    Spacer()
                
                NavigationLink(
                    destination: ChatView(), tag: 1, selection: $inquiryUserDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            .onAppear(perform: {
                inquiryUserDataModel.getOwnerChatroomList(dialogsDataModel: dialogsDataModel)
                dialogsDataModel.getUnreadMessageCounts()
                AppBadgeNumber.getUnreadMessageCounts()
            })
    }
}

