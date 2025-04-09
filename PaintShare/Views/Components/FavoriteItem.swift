//
//  FavoriteItem.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/23.
//

import SwiftUI

struct FavoriteItem: View {
    
    var favoriteListItem:FavoriteListItem
    
    
    var body: some View {
        HStack {
            ZStack {
                VStack {
                    HStack(spacing: 10) {
                        ImageView(withURL: favoriteListItem.paintLikeDto.paintDto.materialImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + favoriteListItem.paintLikeDto.paintDto.materialImgKey!, onClick: {
                            img in
                        }).frame(width: 68, height: 68)
                            .clipped()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                
                                Text(favoriteListItem.paintLikeDto.paintDto.ownedBy.groupName ?? "")
                                    .font(.regular12)
                                    .foregroundColor(.mainText)
                                
                                
                                Text(favoriteListItem.paintLikeDto.paintDto.goodsNameName ?? "")
                                    .font(.medium16)
                                    .foregroundColor(.mainText)
                                
                                
                                Text(favoriteListItem.paintLikeDto.paintDto.price != nil ? String(favoriteListItem.paintLikeDto.paintDto.price!) + "円": " ")
                                    .font(.regular13)
                                    .foregroundColor(.mainText)
                            }
                            Spacer(minLength: 0)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 16)
                    
                    Rectangle()
                        .fill(Color(hex: "#7070704D" ))
                        .frame(height: 1)
                        .padding(.top,0)
                }
                .padding(.bottom,0)
                
                VStack {
                    Spacer()
                    HStack(spacing:0){
                        Spacer()
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .frame(width: 35, height: 35)
                        
                        Text(favoriteListItem.paintLikeDto.paintDto.likeCount != nil ? String(favoriteListItem.paintLikeDto.paintDto.likeCount) : " ")
                            .font(.regular16)
                            .foregroundColor(Color(hex: "#545353"))
                        
                    }
                    .padding(.trailing,25)
                }
                .padding(.bottom,10)
                
            }
        }
        .frame(height: 100)
        .contentShape(Rectangle())
        .padding(.leading,0)
        
    }
}
