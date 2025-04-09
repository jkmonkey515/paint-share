//
//  WarehouseListView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/07.
//

import SwiftUI

struct WarehouseListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var warehouseDataModel:WarehouseDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var warehouseInfoChangeDataModel:WarehouseInfoChangeDataModel
    
    @EnvironmentObject var requestFormDataModel: RequestFormDataModel
        
    @EnvironmentObject var inventoryDataModel:InventoryDataModel
    
    var body: some View {
        
   
            RefreshableScrollView(onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    warehouseDataModel.searchFromZeroPage( dialogsDataModel: dialogsDataModel)
                    done()
                }
            }){
                VStack{
                    ForEach(warehouseDataModel.warehouseListItem,id: \.self){
                        warehouse in
                        WarehouseListTitle(warehouseListItem: warehouse, tag: 1)
                            .onTapGesture(perform: {
                                if(warehouseDataModel.selectedWarehouseMenuTab != 1){
                                warehouseDataModel.reset()
                                    warehouseInfoChangeDataModel.setWarehouseInfo(id: warehouse.warehouseDto.id, dialogsDataModel: dialogsDataModel)
                                warehouseDataModel.navigationTag = 1
                                }
                            })
                    }
                    
                    if(warehouseDataModel.count > warehouseDataModel.warehouseListItem.count){
                        HStack {
                            HStack(spacing:3) {
                                Text("もっと見る")
                                    .font(.regular18)
                                    .foregroundColor(Color(hex:"#56B8C4"))
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color(hex:"#56B8C4"))
                            }
                                    .frame(width: UIScreen.main.bounds.size.width - 40,height: 40)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color(hex:"#56B8C4"), lineWidth: 1)
                                    )
                                .onTapGesture(perform: {
                                    warehouseDataModel.loadMore(dialogsDataModel: dialogsDataModel)
                                })
                        }
                        .padding(.top,20)
                        .padding(.bottom, 40)
                    
                        
                    }
                }
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            .onAppear(perform: {
                if dialogsDataModel.loginNavigationTag == nil {
                    return
                }
                warehouseDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
                warehouseDataModel.selectedWarehouseMenuTab=0//
            })
    }
}
