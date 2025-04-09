//
//  InquiryListTitle.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/20.
//

import SwiftUI

struct InquiryListItem: View {
    
    var chatroomListItem:ChatroomListItem
    
    var numberMark: Int = 0
    
    var body: some View {
        HStack {
            VStack {
                ZStack {
                    HStack(spacing: 10) {
                        ZStack {
                            ImageView(withURL: chatroomListItem.chatroomDto.paint.materialImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + chatroomListItem.chatroomDto.paint.materialImgKey!, onClick: {
                                img in
                            }).frame(width:68,height:68)
                                .clipped()
                           // ReceptionLabel()
                            
                        }
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text( "【問い合わせ】" )
                                        .font(.regular16)
                                        .foregroundColor(.mainText)
                                    
                                    Text(chatroomListItem.chatroomDto.paint.ownedBy.groupName ?? "")//
                                        .font(.regular12)
                                        .foregroundColor(.mainText)
                                    
                                }
                                Text(chatroomListItem.chatroomDto.paint.goodsNameName ?? "")//
                                    .font(.medium16)
                                    .foregroundColor(.mainText)
                                HStack {
                                    
                                    if(chatroomListItem.chatroomDto.lastMessage?.type==0){
                                    Text(chatroomListItem.chatroomDto.lastMessage?.text ?? "")
                                        .lineLimit(1)
                                        .font(.regular14)
                                        .foregroundColor(Color(hex: "#707070"))
                                    }else if(chatroomListItem.chatroomDto.lastMessage?.type==1){
                                        Text("「画像」")
                                            .lineLimit(1)
                                            .font(.regular14)
                                            .foregroundColor(Color(hex: "#707070"))
                                        
                                    }else if(chatroomListItem.chatroomDto.lastMessage?.type==2){
                                            Text("「位置」")
                                                .lineLimit(1)
                                                .font(.regular14)
                                                .foregroundColor(Color(hex: "#707070"))
                                        
                                    }
    //                                Text("3ヶ月前")
    //                                    .font(.regular12)
    //                                    .foregroundColor(.mainText)
    //                                Text("評価をしました")
    //                                    .font(.regular14)
    //                                    .foregroundColor(.mainText)
                                    
    //                                Text(chatroomListItem.chatroomDto.paint.price != nil ? String(chatroomListItem.chatroomDto.paint.price!) : "")
    //                                    .font(.regular13)
    //                                    .foregroundColor(.mainText)
                                }
                            }
                            Spacer(minLength: 0)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.leading, 10)
                .padding(.trailing, 16)
                    
                    HStack{
                        Spacer()
                    if (numberMark != 0) {
                        if (numberMark > 9) {
                            Text("9+")
                                .font(.regular10)
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(Color(hex: "f16161"))
                                        .frame(width: 20, height: 20)
                                )
                                .padding(.trailing, 30)
                        }else{
                        Text(String(numberMark))
                            .font(.regular10)
                            .foregroundColor(.white)
                            .background(
                                Circle()
                                    .fill(Color(hex: "f16161"))
                                    .frame(width: 20, height: 20)
                            )
                            .padding(.trailing, 30)
                        }
                    }
                }
                }
                
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
