//
//  WarehouseListTitle.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/03.
//

import SwiftUI

struct WarehouseListTitle: View {
    
    @EnvironmentObject var warehouseDataModel:WarehouseDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var warehouseListItem:WarehouseListItem

    var tag:Int
    
    var body: some View {
        HStack{
            VStack(spacing:0) {
                HStack (spacing:0){
                    
                    Image(systemName:warehouseDataModel.selectedWarehouseMenuTab == 1 ?  "minus.circle.fill" :"")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 25,height: 25)
                        .foregroundColor(Color(hex: "#E38F97"))
                        .padding(.leading)
                        .onTapGesture {
                            if(warehouseDataModel.selectedWarehouseMenuTab == 1){
                                if warehouseListItem.warehouseDto.paintsCount != 0 {
                                    warehouseDataModel.showCantDeleteNoti = true
                                    return
                                }
                            warehouseDataModel.warehouseDeleteId = warehouseListItem
                                .warehouseDto.id
                            warehouseDataModel.showDeleteWarehouse = true
                            }
                        }
                    
                    VStack(spacing:0){
                        HStack{
                            Text("最終更新日")
                                .font(.regular10)
                                .foregroundColor(Color(hex:"#545353"))
                            Text(DateTimeUtils.timestampToStr(timestamp: warehouseListItem.warehouseDto.updatedAt))
                                .font(.regular10)
                                .foregroundColor(Color(hex:"#545353"))
                                .padding(.leading)
                            Spacer()
                        }
                        .frame( height: 15)
                        .padding(.top,18)
                        
                        HStack {
                            Text(warehouseListItem.warehouseDto.name)
                                .font(.bold16)
                                .foregroundColor(Color(hex:"#545353"))
                            
                            Spacer()
                        }
                        .padding(.top,0)
                        
                        HStack{
                            Text("在庫数")
                                .font(.regular13)
                                .fontWeight(.medium)
                                .foregroundColor(Color(hex:"#545353"))
                            Text("\(warehouseListItem.warehouseDto.paintsCount ?? 0)")
                                .font(.regular13)
                                .fontWeight(.medium)
                                .frame(width: 52, height: 24)
                                .foregroundColor(Color(hex:"#545353"))
                                .background(Color(hex: "#FFC876"))
                                .cornerRadius(5)
                            
                            Spacer()
                        }
                        .padding(.top,4)
                        
                    }
                    .padding(.leading,20)
                    
//                    Image(systemName:warehouseDataModel.selectedWarehouseMenuTab == 1 ?  "text.aligncenter" :"")
//                        .renderingMode(.template)
//                        .resizable()
//                        .frame(width: 25, height: 21)
//                        .foregroundColor(Color(hex: "#E0E0E0"))
//                        .padding(.trailing,20)
//                        .onTapGesture {
//                            //move
//                        }
                }
                Rectangle()
                    .fill(Color(hex: "#7070704D"))
                    .frame(height: 1)
                    .padding(.top,14)
                
            }.padding(.bottom,0)
            
        }
        .frame(height: 100)
        .contentShape(Rectangle())
        .padding(.leading,0)
        
    }
}
