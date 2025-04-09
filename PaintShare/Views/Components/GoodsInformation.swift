//
//  GoodsInformation.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/24.
//

import SwiftUI

struct GoodsInformation: View {
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var orderDetailsDataModel :OrderDetailsDataModel
    
    var body: some View {
        VStack(spacing:0) {
            HStack(spacing:0) {
                Text("商品情報")
                    .font(.medium16)
                    .foregroundColor(Color(hex: "#46747E"))
                Spacer()
            }
            ImageView(withURL: orderDetailsDataModel.materialImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + orderDetailsDataModel.materialImgKey!, onClick: {
                img in
            }).frame(width: 130, height: 130)
                .clipped()
                .padding(.top,5)
            
            VStack(spacing:5){
                CommonTextField(label: "グループ", placeholder: "", value:$orderDetailsDataModel.groupName, disabled: true)
                CommonTextField(label: "倉庫", placeholder: "", value: $orderDetailsDataModel.warehouseName, disabled: true)
                CommonTextField(label: "メーカー", placeholder: "", value: $orderDetailsDataModel.makerName, disabled: true)
                CommonTextField(label: "商品名", placeholder: "", value: $orderDetailsDataModel.goodName, disabled: true)
                CommonTextField(label: "用途区分", placeholder: "", value: $orderDetailsDataModel.useCategoryValue, disabled: true)
                //---------------------------------------------------------------------------------------------------
                Group{
                    HStack{
                        Text("色")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Spacer()
                    }
                    .padding(.trailing, 5)
                    HStack(alignment: .bottom, spacing: 20){
                        Rectangle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color(hex: orderDetailsDataModel.colorCode))
                            .shadow(color: Color(.black).opacity(0.16), radius: 6, x: 0, y: 3)
                        VStack(alignment: .leading,spacing: 3){
                            Spacer()
                            /*
                            Text(orderDetailsDataModel.colorName != "該当なし" ? orderDetailsDataModel.colorName : "")
                                .font(.regular12)
                                .foregroundColor(.mainText)
                             */
                            Text(orderDetailsDataModel.colorName)
                                .font(.medium16)
                                .foregroundColor(.mainText)
                                .padding(.bottom, 5)
                        }
                        Spacer()
                    }
                    .frame(height: 105)
                    .padding(.bottom, 20)
                    .underlineTextField()
                }
                //---------------------------------------------------------------------------------------------------
                CommonTextField(label: "重量（kg）", placeholder: "", color: orderDetailsDataModel.paintWeight.contains("計量中") ? Color(hex: "#56B8C4") : .mainText, value: $orderDetailsDataModel.paintWeight, disabled: true)
                HStack(spacing: 0){
                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .foregroundColor(Color(hex: "#56B8C4"))
                        .frame(width: 14, height: 14)
                        
                    Text("購入された総重量です。")
                        .font(.regular12)
                        .foregroundColor(.subText)
                    Spacer()
                }
                CommonTextField(label: "価格", placeholder: "", value: $orderDetailsDataModel.paintPrice, disabled: true, commabled: true)
            }
            .padding(.top,3)
        }
        .frame(width:UIScreen.main.bounds.size.width - 40)
        .onAppear(perform: {
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
        })
    }
}
