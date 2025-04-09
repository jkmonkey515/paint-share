//
//  MemberItem.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/24/21.
//

import SwiftUI

struct MemberItem: View {
    
    var memberListItem: MemberListItem
    
    var type: Int = 0
    
    @State var vibrateOnRing = false
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var memberManagementDataModel: MemberManagementDataModel
    
    @EnvironmentObject var memberCancelDataModel: MemberCancelDataModel
    
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                if type == 1 {
                    OvalLabel(text: memberListItem.statusInGroup == 5 ? "ブロック中" : "解除済み", width: 90, height: 21, bgColor: Color(hex: memberListItem.statusInGroup == 5 ? "#F16161" : "#E0E0E0"))
                }else{
                    OvalLabel(text: memberListItem.statusInGroupDisplayName, width: 90, height: 21, bgColor: Color(hex: memberListItem.statusInGroup == 1 ? "1db78b" : "1e94fa"))
                }
                ImageView(withURL: memberListItem.userDto.profileImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + memberListItem.userDto.profileImgKey!, onClick: {
                    img in
                }).frame(width: 45, height: 45)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("ID：\(memberListItem.userDto.generatedUserId)")
                        .font(.light10)
                        .foregroundColor(.mainText)
                    Text("\(memberListItem.userDto.lastName)　\(memberListItem.userDto.firstName)")
                        .font(.bold16)
                        .foregroundColor(.mainText)
                    Text(memberListItem.userDto.profile ?? "")
                        .font(.light10)
                        .foregroundColor(.mainText)
                        .lineLimit(3)
                }
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
            VStack {
                if type == 1 {
                    HStack(spacing: 0){
                        Text("解除/")
                            .font(.regular10)
                            .foregroundColor(.mainText)
                        Text("ブロック")
                            .font(.regular10)
                            .foregroundColor(Color(hex: memberListItem.statusInGroup == 5 ? "#A3E8F1" : "#545353"))
                    }
                    Toggle(isOn: $vibrateOnRing) {
                        Text("")
                    }
                    .padding(.trailing, 15)
                    .onTapGesture {
                        if vibrateOnRing == false {
                            memberCancelDataModel.userIdToBlock = memberListItem.id
                            memberCancelDataModel.showBlock = true
                        }else{
                            memberCancelDataModel.userIdToBlock = memberListItem.id
                            memberCancelDataModel.unblock(dialogsDataModel: dialogsDataModel)
                        }
                    }
                    LabelButton(text: "削除", color: .caution, onClick: {
                        memberCancelDataModel.userIdToDelete = memberListItem.userDto.id
                        memberCancelDataModel.showRemove = true
                    })
                }else{
                    LabelButton(text: "削除", color: .caution, onClick: {
                        memberManagementDataModel.userIdToDelete = memberListItem.userDto.id
                        memberManagementDataModel.showDeleteConfirmDialog = true
                    })
                }
            }
            .frame(width: 70)
        }
        .padding(.horizontal, 17)
        .padding(.top, 30)
        .padding(.bottom, 15)
    }
}
