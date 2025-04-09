//
//  PhotographItem.swift
//  PaintShare
//
//  Created by Lee on 2022/7/15.
//

import SwiftUI

struct PhotographItem: View {
    
    var memberListItem: GroupImageUseDtoListItem
    
    var type: Int = 0
    
    var body: some View {
        HStack(spacing: 10) {
            VStack {
                ImageView(withURL: memberListItem.imageUser.profileImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + memberListItem.imageUser.profileImgKey!, onClick: {
                    img in
                }).frame(width: 45, height: 45)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("ID：\(memberListItem.imageUser.generatedUserId)")
                        .font(.light10)
                        .foregroundColor(.mainText)
                    Text("\(memberListItem.imageUser.lastName)　\(memberListItem.imageUser.firstName)")
                        .font(.bold16)
                        .foregroundColor(.mainText)
                }
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
            ZStack{
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color(hex: "#A3E8F1"))
                    .frame(width: 46, height: 28)
                Text("\(memberListItem.useCount)")
                    .font(.medium16)
                    .foregroundColor(Color(hex: "#545353"))
            }
        }
        .padding(.horizontal, 17)
        .padding(.top, 15)
        .padding(.bottom, 15)
    }
}
