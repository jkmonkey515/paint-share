//
//  InquiryUserItem.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/20.
//

import SwiftUI

struct InquiryUserItem: View {
    
    var chatroomUsersListItem:ChatroomUsersListItem
    
    var numberMark: Int = 0
    
    var body: some View {
        HStack {
            VStack {
                ZStack {
                    HStack(spacing: 10) {
                        ZStack {
                            ImageView(withURL: chatroomUsersListItem.chatroomDto.participant.profileImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + chatroomUsersListItem.chatroomDto.participant.profileImgKey!, onClick: {
                                img in
                            }).frame(width:68,height:68)
                                .clipped()
                        }
                        
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("【問い合わせ】")
                                        .font(.medium16)
                                        .foregroundColor(.mainText)
                                }
                                Text(chatroomUsersListItem.chatroomDto.participant.lastName + " " + chatroomUsersListItem.chatroomDto.participant.firstName)
                                    .font(.regular14)
                                    .foregroundColor(.mainText)
                                HStack {
                                    Text(chatroomUsersListItem.chatroomDto.displayGroupName)
                                        .font(.regular14)
                                        .foregroundColor(.mainText)
                                    
                                }
                                //                            HStack{
                                //                             RankCountsLabel(rank0Count: 2, rank1Count: 0, rank2Count: 0, imageSize: 20, font: .regular14, textWidth: 15)
                                //
                                //                                Text("12月15日")
                                //                                    .font(.regular14)
                                //                                    .foregroundColor(.mainText)
                                //                                    .padding(.leading,5)
                                //                            }
                                
                                HStack{
                                    if(chatroomUsersListItem.chatroomDto.lastMessage?.type==0){
                                    Text(chatroomUsersListItem.chatroomDto.lastMessage?.text ?? "")
                                        .lineLimit(1)
                                        .font(.regular14)
                                        .foregroundColor(Color(hex: "#707070"))
                                    }else if(chatroomUsersListItem.chatroomDto.lastMessage?.type==1){
                                        Text("「画像」")
                                            .lineLimit(1)
                                            .font(.regular14)
                                            .foregroundColor(Color(hex: "#707070"))
                                        
                                    }else if(chatroomUsersListItem.chatroomDto.lastMessage?.type==2){
                                            Text("「位置」")
                                                .lineLimit(1)
                                                .font(.regular14)
                                                .foregroundColor(Color(hex: "#707070"))
                                        
                                    }
//                                    Text("Hi")
//                                        .lineLimit(1)
//                                        .font(.regular14)
//                                        .foregroundColor(Color(hex: "#707070"))
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
                    .fill(Color(hex: "#7070704D"))
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
