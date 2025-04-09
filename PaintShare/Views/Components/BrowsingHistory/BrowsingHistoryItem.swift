//
//  BrowsingHistoryItem.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/23.
//

import SwiftUI

struct BrowsingHistoryItem: View {
    
    var browsingHistoryListItem:BrowsingHistoryListItem
    
    var body: some View {
        HStack {
            VStack {
                HStack(spacing: 10) {
                    ImageView(withURL: browsingHistoryListItem.paintViewDto.paintDto.materialImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + browsingHistoryListItem.paintViewDto.paintDto.materialImgKey!, onClick: {
                        img in
                    }).frame(width: 68, height: 68)
                        .clipped()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            
                            Text(browsingHistoryListItem.paintViewDto.paintDto.ownedBy.groupName ?? "")
                                .font(.regular12)
                                .foregroundColor(.mainText)
                            
                            Text(browsingHistoryListItem.paintViewDto.paintDto.goodsNameName ?? "")
                                .font(.medium16)
                                .foregroundColor(.mainText)
                            
                            Text(browsingHistoryListItem.paintViewDto.paintDto.price != nil ? String(browsingHistoryListItem.paintViewDto.paintDto.price!) + "円": " ")
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
        }
        .frame(height: 100)
        .contentShape(Rectangle())
        .padding(.leading,0)    }
}
