//
//  WaitlistItem.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/15/21.
//

import SwiftUI

struct WaitItem: View {
    
    var waitListItem: WaitListItem
    
    @EnvironmentObject var approvalWaitListDataModel: ApprovalWaitlistDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                OvalLabel(text: waitListItem.statusInGroupDisplayName, width: 90, height: 21, bgColor: Color(hex: waitListItem.statusInGroup == 0 || waitListItem.statusInGroup == 4 ? "1db78b" : "1e94fa"))
                ImageView(withURL: waitListItem.userDto.profileImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + waitListItem.userDto.profileImgKey!, onClick: {
                    img in
                }).frame(width:45,height:45)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }
            VStack(alignment: .leading) {
                Text("ID：\(waitListItem.userDto.generatedUserId)")
                    .font(.light10)
                    .foregroundColor(.mainText)
                Text("\(waitListItem.userDto.lastName)　\(waitListItem.userDto.firstName)")
                    .font(.bold16)
                    .foregroundColor(.mainText)
                Text(waitListItem.userDto.profile ?? "")
                    .font(.light10)
                    .foregroundColor(.mainText)
                    .lineLimit(3)
            }
            Spacer()
            VStack {
                LabelButton(text: "承認", onClick: {
                    approvalWaitListDataModel.approve(dialogsDataModel: dialogsDataModel, id: waitListItem.id)
                })
                LabelButton(text: "削除", color: .caution, onClick: {
                    approvalWaitListDataModel.relationIdToDelete = waitListItem.id
                    approvalWaitListDataModel.showDeleteConfirmDialog = true
                })
            }
            .frame(width: 70)
        }
        .padding(.horizontal, 17)
        .padding(.top, 30)
        .padding(.bottom, 15)
    }
}
