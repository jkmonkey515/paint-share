//
//  OrderItem.swift
//  PaintShare
//
//  Created by Lee on 2022/7/22.
//

import SwiftUI

struct OrderItem: View {
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var orderListDataModel: OrderListDataModel
    
    var orderListItem: OrderListItem
    
    var body: some View {
        HStack{
            ImageView(withURL: orderListItem.order.materialImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + orderListItem.order.materialImgKey!, onClick: {
                img in
            }).frame(width: 60, height: 60)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            HStack {
                VStack(alignment: .leading) {
                    Text(orderListItem.order.groupName)
                        .font(.regular14)
                        .foregroundColor(.mainText)
                        .lineLimit(1)
                    Text(orderListItem.order.paintName)
                        .font(.bold16)
                        .foregroundColor(.mainText)
                        .lineLimit(1)
                    Text("\(orderListItem.order.price ?? 0)円")
                        .font(.regular14)
                        .foregroundColor(.mainText)
                        .lineLimit(1)
                }
                Spacer(minLength: 0)
            }.padding(.horizontal, 21)
            .frame(maxWidth: .infinity)
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
