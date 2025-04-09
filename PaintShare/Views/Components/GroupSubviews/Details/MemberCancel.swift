//
//  MemberCancel.swift
//  PaintShare
//
//  Created by Lee on 2022/5/23.
//

import SwiftUI

struct MemberCancel: View {
    
    @EnvironmentObject var memberManagementDataModel: MemberManagementDataModel
    
    @EnvironmentObject var memberDetailInfoDataModel: MemberDetailInfoDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var groupInfoChangeDataModel: GroupInfoChangeDataModel
    
    @EnvironmentObject var memberCancelDataModel: MemberCancelDataModel
    
    var body: some View {
        ZStack {
        VStack {
            CommonHeader(title: "解除したメンバー", showBackButton: true, showHamburgerButton: false, onBackClick: {
                memberManagementDataModel.navigationTag = nil
            })
            HStack(spacing: 20) {
                HStack {
                    Image("magnifiying-glass")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color(hex: "c2c2c2"))
                        .padding(.leading, 10)
                    TextField("Search...", text: $memberCancelDataModel.searchPhrase, onCommit: {
                        memberCancelDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
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
                            memberCancelDataModel.searchPhrase = ""
                        })
                }
                .frame(height: 30)
                .background(Color(hex: "f3f3f3"))
                .cornerRadius(4)
                
                Text("Cancel")
                    .font(.regular12)
                    .foregroundColor(.mainText)
                    .onTapGesture(perform: {
                        memberCancelDataModel.searchPhrase = ""
                        memberCancelDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
                    })
            }
            .padding(.leading, 10)
            .padding(.trailing, 20)
            
            HStack {
                Text("メンバー：\(memberCancelDataModel.numberOfDelete)人")
                    .font(.regular12)
                    .foregroundColor(.mainText)
                    .padding(.leading, 17)
                Spacer()
            }
            
            ZStack{
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color(hex: "#A3E8F1"))
                    .frame(width: UIScreen.main.bounds.size.width, height: 48)
                VStack(alignment: HorizontalAlignment.center, spacing: 0){
                    Text("削除したメンバーは3ヶ月経過すると")
                        .font(.regular14)
                    Text("リストから自動的に消えます")
                        .font(.regular14)
                }
            }
            
            RefreshableScrollView(onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    memberCancelDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
                    done()
                }
            }) {
                VStack {
                    ForEach(memberCancelDataModel.memberListItems) {
                        item in
                        MemberItem(memberListItem: item, type:1, vibrateOnRing: item.statusInGroup == 5 ? true : false)
                            .underlineListItem()
                            .onTapGesture(perform: {
                                memberDetailInfoDataModel.memberListItem = item
                                memberCancelDataModel.navigationTag = 1
                            })
                        
                    }
                }
            }
            NavigationLink(
                destination: MemberDetailInfo(), tag: 1, selection: $memberCancelDataModel.navigationTag) {
                EmptyView()
            }.isDetailLink(false)
            .frame(width: 0, height: 0)
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
            debugPrintLog(message:"member cancel appear")
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
            memberCancelDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
        })
    }
}
