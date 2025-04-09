//
//  MemberManagement.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/24/21.
//

import SwiftUI

struct MemberManagement: View {
    
    @EnvironmentObject var memberManagementDataModel: MemberManagementDataModel
    
    @EnvironmentObject var memberDetailInfoDataModel: MemberDetailInfoDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var groupInfoChangeDataModel: GroupInfoChangeDataModel
    
    @EnvironmentObject var memberCancelDataModel: MemberCancelDataModel
    
    var body: some View {
        ZStack {
        VStack {
            CommonHeader(title: "メンバー管理", showBackButton: true, showHamburgerButton: false, onBackClick: {
                groupInfoChangeDataModel.navigationTag = nil
            })
            HStack(spacing: 20) {
                HStack {
                    Image("magnifiying-glass")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color(hex: "c2c2c2"))
                        .padding(.leading, 10)
                    TextField("Search...", text: $memberManagementDataModel.searchPhrase, onCommit: {
                        memberManagementDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
                    })
                    .autocapitalization(.none)
                    .font(.regular12)
                    .foregroundColor(.mainText)
                    Image(systemName: "xmark.circle.fill")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color(hex: "c1c1c1"))
                        .padding(.trailing, 10)
                        .onTapGesture(perform: {
                            memberManagementDataModel.searchPhrase = ""
                        })
                }
                .frame(height: 30)
                .background(Color(hex: "f3f3f3"))
                .cornerRadius(4)
                
                Text("Cancel")
                    .font(.regular12)
                    .foregroundColor(.mainText)
                    .onTapGesture(perform: {
                        memberManagementDataModel.searchPhrase = ""
                        memberManagementDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
                    })
            }
            .padding(.leading, 10)
            .padding(.trailing, 20)
            
            HStack {
                Text("メンバー：\(memberManagementDataModel.numberOfJoined)人、フレンド：\(memberManagementDataModel.numberOfShared)人")
                    .font(.regular12)
                    .foregroundColor(.mainText)
                    .padding(.leading, 17)
                Spacer()
                NavigationLink(
                    destination: MemberCancel().onDisappear(perform: {
                        debugPrintLog(message:"member cancel disappear")
                        memberManagementDataModel.getMembersCount(dialogsDataModel: dialogsDataModel)
                    }), tag: 2, selection: $memberManagementDataModel.navigationTag) {
                    EmptyView()
                }.isDetailLink(false)
                
                Text("解除したメンバー")
                    .font(.regular12)
                    .foregroundColor(.primary)
                    .padding(.trailing, 17)
                    .onTapGesture(perform: {
                        memberCancelDataModel.groupId = memberManagementDataModel.groupId
                        memberManagementDataModel.navigationTag = 2
                    })
            }
            
            RefreshableScrollView(onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    memberManagementDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
                    done()
                }
            }) {
                VStack {
                    ForEach(memberManagementDataModel.memberListItems) {
                        item in
                        MemberItem(memberListItem: item)
                            .underlineListItem()
                            .onTapGesture(perform: {
                                memberDetailInfoDataModel.memberListItem = item
                                memberManagementDataModel.navigationTag = 1
                            })
                        
                    }
                    //---------- page ----------
                    if(memberManagementDataModel.totalElements > memberManagementDataModel.memberListItems.count){
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
                                        memberManagementDataModel.loadMore(dialogsDataModel: dialogsDataModel)
                                })
                        }
                        .padding(.top,20)
                        .padding(.bottom, 40)
                    }
                    //----------------------
                }
            }
            NavigationLink(
                destination: MemberDetailInfo(), tag: 1, selection: $memberManagementDataModel.navigationTag) {
                EmptyView()
            }.isDetailLink(false)
            .frame(width: 0, height: 0)
            NavigationLink(destination: EmptyView()) {
                EmptyView()
            }
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
            debugPrintLog(message:"member appear")
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
            memberManagementDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
        })
    }
}
