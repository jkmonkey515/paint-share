//
//  InventoryListItem.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/04/23.
//

import SwiftUI

struct InventoryListItem: View {
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    @EnvironmentObject var inventorySearchDataModel: InventorySearchDataModel
    @State private var loadImage: Bool = false
    
    var inventorySearchItem: InventorySearchItem
    
    var body: some View {
        HStack(spacing: 10){
            ImageView(withURL: inventorySearchItem.materialImgKey == nil || loadImage == false ? "" : UrlConstants.IMAGE_S3_ROOT + inventorySearchItem.materialImgKey!, onClick: {
                img in
            }).frame(width: 73, height: 73)
                .clipped()
            VStack(alignment: .leading, spacing: 2){
                Text(inventorySearchItem.maker.name)
                    .font(.regular12)
                    .foregroundColor(.mainText)
                Text(inventorySearchItem.goodsNameName)
                    .font(.bold16)
                    .foregroundColor(.mainText)
                if inventorySearchItem.saleFlag == 1{
                    Text(Constants.showTheComma(source:String(inventorySearchItem.price ?? 0))+"円")
                        .font(.regular10)
                        .foregroundColor(Color(hex: "#E87652"))
                }
                Text(inventorySearchItem.useCategory != nil ? "\(inventorySearchItem.useCategory?.name ?? "") ／ \(DateTimeUtils.dateStrFormat(dateStr: inventorySearchItem.expireDate) )" : "\(DateTimeUtils.dateStrFormat(dateStr: inventorySearchItem.expireDate) )")
                    .font(.light10)
                    .foregroundColor(.mainText)
                HStack{
                    Text("色：")
                        .font(.light10)
                        .foregroundColor(.mainText)
                    if (inventorySearchDataModel.sharedGroupList.contains(inventorySearchItem.ownedBy.id) && inventorySearchItem.ownedBy.goodsPublic == 1)
                    {
                        if ((inventorySearchItem.colorNumber) != nil) {
                            if inventorySearchItem.colorNumber?.colorNumber != "該当なし" {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(hex: inventorySearchItem.colorNumber?.colorCode ?? "000000"))
                                    .frame(width: 100, height: 15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color(hex: "707070").opacity(0.13), lineWidth: 1))
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(hex: "54B58F"))
                                    .frame(width: 45, height: 15)
                                    .overlay(
                                        Text("共有中")
                                            .foregroundColor(.white)
                                            .font(.light10)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color(hex: "707070").opacity(0.13), lineWidth: 1))
                            }else{
                                Text("該当なし")
                                    .font(.light10)
                                    .foregroundColor(.mainText)
                                    .frame(width: 100, height: 15, alignment: .leading)
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(hex: "54B58F"))
                                    .frame(width: 45, height: 15)
                                    .overlay(
                                        Text("共有中")
                                            .foregroundColor(.white)
                                            .font(.light10)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color(hex: "707070").opacity(0.13), lineWidth: 1))
                            }
                        }
                        else {
                            Text(inventorySearchItem.otherColorName ?? "")
                                .font(.light10)
                                .foregroundColor(.mainText)
                                .frame(width: 100, height: 15, alignment: .leading)
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(hex: "54B58F"))
                                .frame(width: 45, height: 15)
                                .overlay(
                                    Text("共有中")
                                        .foregroundColor(.white)
                                        .font(.light10)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color(hex: "707070").opacity(0.13), lineWidth: 1))
                        }
                        
                    }
                    else{
                        if ((inventorySearchItem.colorNumber) != nil) {
                            if inventorySearchItem.colorNumber?.colorNumber != "該当なし" {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(hex: inventorySearchItem.colorNumber?.colorCode ?? "000000"))
                                    .frame(width: 155, height: 15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color(hex: "707070").opacity(0.13), lineWidth: 1))
                            }else{
                                Text("該当なし")
                                    .font(.light10)
                                    .foregroundColor(.mainText)
                                    .frame(width: 155, height: 15, alignment: .leading)
                            }
                        }
                        else {
                            Text(inventorySearchItem.otherColorName ?? "")
                                .font(.light10)
                                .foregroundColor(.mainText)
                                .frame(width: 155, height: 15, alignment: .leading)
                        }
                    }
                }
            }
            .frame(width: 190, height: 76)
            VStack(spacing: 3){
                if inventorySearchItem.expireDate != "" {
                    if dialogsDataModel.dateJudge(inventorySearchItem.expireDate) == 1 {
                        HStack{
                            Spacer()
                            Image("expired")
                                .resizable()
                                .frame(width: 15.5, height: 25.5)
                                .foregroundColor(Color(hex:"#F6B911"))
                                .clipped()
                        }
                        .frame(width: 15.5, height: 25.5)
                    }else if dialogsDataModel.dateJudge(inventorySearchItem.expireDate) == 2 {
                        HStack{
                            Spacer()
                            Image("nearlyExpired")
                                .resizable()
                                .frame(width: 15.5, height: 25.5)
                                .foregroundColor(Color(hex:"#E87652"))
                                .clipped()
                        }
                        .frame(width: 15.5, height: 25.5)
                    }else if dialogsDataModel.dateJudge(inventorySearchItem.expireDate) == 3 {
                        
                    }else{
                        
                    }
                }
                if inventorySearchItem.expireDate != "" {
                    VStack{
                        Text(String(inventorySearchItem.amount))
                            .font(.bold16)
                            .foregroundColor(.mainText)
                            .padding(.top, dialogsDataModel.dateJudge(inventorySearchItem.expireDate) != 3 ? 4 : 14)
                        Text("缶")
                            .font(.light10)
                            .foregroundColor(.mainText)
                    }
                    .frame(width: 59, height: dialogsDataModel.dateJudge(inventorySearchItem.expireDate) != 3 ? 42 : 59)
                    .background(Color(hex:"fce2a9").opacity(0.5))
                    .cornerRadius(5)
                }else{
                    VStack{
                        Text(String(inventorySearchItem.amount))
                            .font(.bold16)
                            .foregroundColor(.mainText)
                            .padding(.top, 14)
                        Text("缶")
                            .font(.light10)
                            .foregroundColor(.mainText)
                    }
                    .frame(width: 59, height: 59)
                    .background(Color(hex:"fce2a9").opacity(0.5))
                    .cornerRadius(5)
                }
            }
        }
        .frame(width: 350, height: inventorySearchItem.saleFlag == 1 ? 105 : 95)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(hex: "707070").opacity(0.2)),
            alignment: .bottom
        )
        .onAppear(perform: {
            //debugPrintLog(message:"inventory appear")
            loadImage = true
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
        })
        .onDisappear(perform: {
            loadImage = false
            
        })
    }
}
