//
//  RequestDetailInfo.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/26/21.
//

import SwiftUI

struct RequestDetailInfo: View {
    
    @EnvironmentObject var requestDetailInfoDataModel: RequestDetailInfoDataModel
    
    @EnvironmentObject var approvalWaitListDataModel: ApprovalWaitlistDataModel
    
    var body: some View {
        VStack(spacing: 0) {
            CommonHeader(title: "申請者情報", showBackButton: true, onBackClick: {
                approvalWaitListDataModel.navigationTag = nil
            })
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Spacer()
                        ImageView(withURL: requestDetailInfoDataModel.waitListItem.userDto.profileImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + requestDetailInfoDataModel.waitListItem.userDto.profileImgKey!, onClick: {
                            img in
                        }).frame(width: 120, height: 120)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                        Spacer()
                    }
                    .padding(.top, 30)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("ユーザーID")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Text(requestDetailInfoDataModel.waitListItem.userDto.generatedUserId)
                            .font(.medium20)
                            .foregroundColor(.mainText)
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text("氏名")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Text("\(requestDetailInfoDataModel.waitListItem.userDto.lastName)　\(requestDetailInfoDataModel.waitListItem.userDto.firstName)")
                            .font(.medium20)
                            .foregroundColor(.mainText)
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text("プロフィール")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Text(requestDetailInfoDataModel.waitListItem.userDto.profile ?? "")
                            .font(.medium20)
                            .foregroundColor(.mainText)
                            .lineLimit(nil)
                    }
                    VStack(alignment: .leading, spacing: 2) {
                        Text("メッセージ")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Text(requestDetailInfoDataModel.waitListItem.requestMessage)
                            .font(.medium20)
                            .foregroundColor(.mainText)
                            .lineLimit(nil)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}
