//
//  GroupSearchItem.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/9/21.
//

import SwiftUI

struct GroupListItem: View {
    
    var groupSearchItem: GroupSearchItem
    
    @State var navigationTag: Int? = nil
    
    var onJoinRequestTap: () -> Void
    
    var onShareRequestTap: () -> Void
    
    var onCancelRequestTap: () -> Void
    
    var onExitRequestTap: () -> Void
    
    @EnvironmentObject var groupSearchDataModel: GroupSearchDataModel
    
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                OvalLabel(text: groupSearchItem.ownedByLoggedinUser ? "オーナー" : (groupSearchItem.statusInGroupDisplayName ?? ""), width: 90, height: 21, bgColor: groupSearchItem.ownedByLoggedinUser ? Color.secondary : Color(hex:  groupSearchItem.statusInGroup == 1 || groupSearchItem.statusInGroup == 0 || groupSearchItem.statusInGroup == 4 ? "1db78b" : "1e94fa"))
                    .opacity((groupSearchItem.statusInGroupDisplayName == nil && !groupSearchItem.ownedByLoggedinUser) ? 0 : 1)
                ImageView(withURL: groupSearchItem.groupDto.groupImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + groupSearchItem.groupDto.groupImgKey!, onClick: {
                    img in
                }).frame(width:68,height:68)
                    .clipped()
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("ID：\(groupSearchItem.groupDto.generatedGroupId)")
                        .font(.light10)
                        .foregroundColor(.mainText)
                    Text(groupSearchItem.groupDto.groupName)
                        .font(.bold16)
                        .foregroundColor(.mainText)
                    Text(groupSearchItem.groupDto.description)
                        .font(.light10)
                        .foregroundColor(.mainText)
                        .lineLimit(3)
                    RankCountsLabel(rank0Count: groupSearchItem.rank0Count, rank1Count: groupSearchItem.rank1Count, rank2Count: groupSearchItem.rank2Count)
                }
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
            VStack {
                if (!groupSearchItem.ownedByLoggedinUser) {
                    if (!groupSearchDataModel.isRelatedSearch) {
                        if (groupSearchItem.groupDto.groupPublic == 1 && (groupSearchItem.statusInGroup == nil || groupSearchItem.statusInGroup == 3)) {
                            LabelButton(text: "メンバー", onClick: {
                                onJoinRequestTap()
                            })
                        }
                        if (groupSearchItem.groupDto.goodsPublic == 1 && groupSearchItem.statusInGroup == nil) {
                            LabelButton(text: "フレンド", onClick: {
                                onShareRequestTap()
                            })
                        }
                    } else {
                        if (groupSearchItem.statusInGroup == 2 || groupSearchItem.statusInGroup == 0 || groupSearchItem.statusInGroup == 4) {
                            LabelButton(text: "取下げ", color: Color.caution, onClick: {
                                onCancelRequestTap()
                            })
                        } else {
                            LabelButton(text: "脱退", color: Color.caution, onClick: {
                                onExitRequestTap()
                            })
                        }
                    }
                }
            }
            .frame(width: 70)
        }
        .padding(.leading, 10)
        .padding(.trailing, 16)
    }
}
