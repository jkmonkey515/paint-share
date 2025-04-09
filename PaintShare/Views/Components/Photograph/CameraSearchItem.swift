//
//  CameraSearchItem.swift
//  PaintShare
//
//  Created by Lee on 2022/7/18.
//

import SwiftUI

struct CameraSearchItem: View {
    
    @EnvironmentObject var inventoryApprovalDataModel: InventoryApprovalDataModel
    
    var cameraListItem: CameraListItem
    
    var body: some View {
        HStack{
            HStack {
                VStack(alignment: .leading) {
                    Text(cameraListItem.groupName)
                        .font(.regular14)
                        .foregroundColor(.mainText)
                        .lineLimit(1)
                    Text(cameraListItem.goodsNameName)
                        .font(.bold16)
                        .foregroundColor(.mainText)
                        .lineLimit(1)
                        .padding(.bottom, -7.5)
                    HStack{
                        Text("色：\(cameraListItem.color)")
                            .font(.regular14)
                            .foregroundColor(.mainText)
                            .lineLimit(1)
                        Rectangle()
                            .fill(Color(hex: cameraListItem.color))
                            .frame(width:81,height: 15)
                            .cornerRadius(7.5)
                    }
                }
                Spacer(minLength: 0)
            }.frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 21)
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
}
