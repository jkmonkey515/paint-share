//
//  ApprovalItem.swift
//  PaintShare
//
//  Created by Lee on 2022/6/21.
//

import SwiftUI

struct ApprovalItem: View {
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var inventoryApprovalDataModel: InventoryApprovalDataModel
    
    var approvalListItem: ApprovalListItem
    
    var body: some View {
        HStack{
            ImageView(withURL: approvalListItem.materialImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + approvalListItem.materialImgKey!, onClick: {
                img in
            }).frame(width: 60, height: 60)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            HStack {
                VStack(alignment: .leading) {
                    Text(approvalListItem.groupName)
                        .font(.regular14)
                        .foregroundColor(.mainText)
                        .lineLimit(1)
                    Text(approvalListItem.goodsNameName)
                        .font(.bold16)
                        .foregroundColor(.mainText)
                        .lineLimit(1)
                    Text("\(approvalListItem.price)円")
                        .font(.regular14)
                        .foregroundColor(.mainText)
                        .lineLimit(1)
                }
                Spacer(minLength: 0)
            }.padding(.horizontal, 21)
            .frame(maxWidth: .infinity)
            VStack{
                LabelButton(text: "承認", color: Color(hex: "#56B8C4"), onClick: {
                    inventoryApprovalDataModel.userIdToApprove = approvalListItem.id
                    inventoryApprovalDataModel.showApprove = true
                })
                LabelButton(text: "削除", color: Color(hex: "#E38F97"), onClick: {
                    inventoryApprovalDataModel.userIdToDelete = approvalListItem.id
                    inventoryApprovalDataModel.showDelete = true
                })
            }
            .frame(width: 70)
        }
        .padding(.horizontal, 21)
        .padding(.top, 20)
        .padding(.bottom, 20)
        .onAppear(perform: {
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
        })
    }
}
