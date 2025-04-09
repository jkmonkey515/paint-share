//
//  InquiryManagementListItem.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/07/06.
//

import SwiftUI

struct InquiryManagementListItem: View {
        
    var chatroomDistinctListItem:ChatroomDistinctListItem
    
    var numberMark: Int = 1
    
    var body: some View {
        HStack {
            VStack {
                HStack(spacing: 10) {
                    ZStack {
                        ImageView(withURL: chatroomDistinctListItem.chatroomDistinctDto.paint.materialImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + chatroomDistinctListItem.chatroomDistinctDto.paint.materialImgKey!, onClick: {
                            img in
                        }).frame(width:68,height:68)
                            .clipped()
                      //  ReceptionLabel()
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(chatroomDistinctListItem.chatroomDistinctDto.paint.ownedBy.groupName ?? "")//
                                    .font(.regular12)
                                    .foregroundColor(.mainText)
                            }
                            Text(chatroomDistinctListItem.chatroomDistinctDto.paint.goodsNameName ?? "")//
                                .font(.medium16)
                                .foregroundColor(.mainText)
                            HStack {
                                Text("問い合わせたユーザー")//
                                    .font(.regular14)
                                    .foregroundColor(.mainText)
                                    Text("("+String(chatroomDistinctListItem.chatroomDistinctDto.groupByChatroomCount)+")")
                                    .font(.regular14)
                                    .foregroundColor(.mainText)
                            }
                        }
                        Spacer(minLength: 0)
                        
//                        Image(systemName:"chevron.right")
//                            .font(Font.system(size: 18, weight: .regular))
//                            .padding(.trailing,5)
                        if (numberMark != 1) {
                                        Circle()
                                            .fill(Color(hex: "f16161"))
                                            .frame(width: 19, height: 19)
                                            .padding(.leading,25)
                                            //.offset(x: 9, y: -9)
                            }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.leading, 10)
                .padding(.trailing, 16)
          
                Rectangle()
                    .fill(Color(hex:"#7070704D"))
                    .frame(height: 1)
                    .padding(.top,0)
            }
            .padding(.bottom,0)
        }
        .frame(height: 100)
        .contentShape(Rectangle())
        .padding(.leading,0)
    }
}

