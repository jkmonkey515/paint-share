//
//  RankListItem.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/23/21.
//

import SwiftUI

struct RankItem: View {
    
    var commentListItem: CommentListItem
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                ImageView(withURL: commentListItem.commentUserDto.profileImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + commentListItem.commentUserDto.profileImgKey!, onClick: {
                    img in
                }).frame(width:45,height:45)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .padding(.all, 5)
                VStack(alignment: .leading) {
                    Text(DateTimeUtils.timestampToStr(timestamp: commentListItem.updatedAt))
                        .font(.light10)
                        .foregroundColor(.mainText)
                    Text("\(commentListItem.commentUserDto.lastName)　\(commentListItem.commentUserDto.firstName)")
                        .font(.regular12)
                        .foregroundColor(.mainText)
                    Text(commentListItem.displayGroupName)
                        .font(.regular12)
                        .foregroundColor(.mainText)
                }
                Spacer()
                RankLabel(rank: commentListItem.rank)
            }
            HStack {
                Text(commentListItem.comment)
                    .font(.regular12)
                    .foregroundColor(.mainText)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
        }
        .padding(.all, 15)
    }
}
