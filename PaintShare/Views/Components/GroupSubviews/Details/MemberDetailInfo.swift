//
//  MemberDetailInfo.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/28/21.
//

import SwiftUI

struct MemberDetailInfo: View {
    
    @EnvironmentObject var memberManagementDataModel: MemberManagementDataModel
    
    @EnvironmentObject var memberDetailInfoDataModel: MemberDetailInfoDataModel
    
    @EnvironmentObject var memberCancelDataModel: MemberCancelDataModel
    
    var body: some View {
        VStack {
            CommonHeader(title: "メンバー詳細情報", showBackButton: true, onBackClick: {
                memberManagementDataModel.navigationTag = nil
                memberCancelDataModel.navigationTag = nil
            })
            ScrollView {
                VStack {
                    ImageView(withURL: memberDetailInfoDataModel.memberListItem.userDto.profileImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + memberDetailInfoDataModel.memberListItem.userDto.profileImgKey!, onClick: {
                        img in
                    }).frame(width: 120, height: 120)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .padding(.bottom, 18)
                    HStack() {
                        Text("ユーザーID")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Spacer()
                    }
                    .padding(.bottom, 2)
                    HStack {
                        Text(memberDetailInfoDataModel.memberListItem.userDto.generatedUserId)
                            .font(.medium20)
                            .foregroundColor(.mainText)
                        Spacer()
                    }
                    .padding(.bottom, 20)
                    HStack {
                        Text("氏名")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Spacer()
                    }
                    .padding(.bottom, 2)
                    HStack {
                        Text(memberDetailInfoDataModel.fullName)
                            .font(.medium20)
                            .foregroundColor(.mainText)
                        Spacer()
                    }
                    .padding(.bottom, 20)
                    HStack {
                        Text("プロフィール")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Spacer()
                    }
                    .padding(.bottom, 2)
                    HStack {
                        Text(memberDetailInfoDataModel.memberListItem.userDto.profile ?? "")
                            .font(.medium16)
                            .foregroundColor(.mainText)
                            .lineLimit(nil)
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 30)
                Spacer()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}
