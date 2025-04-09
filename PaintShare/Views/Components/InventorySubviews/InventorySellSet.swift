//
//  InventorySellSet.swift
//  PaintShare
//
//  Created by Lee on 2022/6/10.
//

import SwiftUI

struct InventorySellSet: View {
    
    @EnvironmentObject var inventorySellSetDataModel: InventorySellSetDataModel
    
    @EnvironmentObject var inventoryDataModel: InventoryDataModel
    
    @EnvironmentObject var inventoryEditDataModel: InventoryEditDataModel
    
    @EnvironmentObject var locationDataModel: LocationDataModel
    
    public var usedBy: Int
    
    public var from: Int = 0
    
    var body: some View {
        VStack(spacing: 20){
            /*
            HStack(spacing:0){
                CommonSelectField(label: "決済方法", placeholder: "選択する",onClick: {
                    inventorySellSetDataModel.showPicker = true
                    inventorySellSetDataModel.pickListId = 0
                    inventorySellSetDataModel.setPackList(pickListId: 0)
                },value:$inventorySellSetDataModel.payValue)
                    .frame(width: 150)
                    .padding(.leading,0)
                Spacer()
            }
             */
            CommonTextField(label: "決済方法", placeholder: "", value: $inventorySellSetDataModel.payWay, disabled: true)
            //GotoOtherViewSelectField(label: "出品エリア", placeholder: "選択する", onClick: {
            GotoOtherViewSelectField(label: "引取りエリア", placeholder: "選択する", onClick: {
                if from != 1{
                    inventorySellSetDataModel.navigationTag = 1
                }
            }, value: usedBy == 1 ? $inventoryDataModel.goodPlace : $inventoryEditDataModel.goodPlace,additionalMessage:"具体的な場所はチャットでやりとり下さい。")
            .onAppear {
                if usedBy == 1{
                    locationDataModel.checkString = ""
                    locationDataModel.checkCodeArray = []
                    locationDataModel.clearCheck()
                }else{
//                    locationDataModel.checkCodeArray = inventoryEditDataModel.goodPlaceCodeArray
//                    locationDataModel.clearCheck()
//                    if locationDataModel.setChecked() != "" {
//                        inventoryEditDataModel.goodPlace = locationDataModel.setChecked()
//                    }
                }
            }
            
            NavigationLink(
                destination: AreaSelection(usedBy: usedBy), tag: 1, selection:$inventorySellSetDataModel.navigationTag) {
                EmptyView()
            }.isDetailLink(false)
            /*
            HStack(spacing:0){
                CommonSelectField(label: "受け渡し方法", placeholder: "選択する",onClick: {
                    inventorySellSetDataModel.showPicker = true
                    inventorySellSetDataModel.pickListId = 1
                    inventorySellSetDataModel.setPackList(pickListId: 1)
                },value:$inventorySellSetDataModel.sendValue)
                    .frame(width: 150)
                    .padding(.leading,0)
                Spacer()
            }
            GotoOtherViewSelectField(label: "受け渡し場所", placeholder: "選択する", onClick: {
                inventorySellSetDataModel.navigationTag = 2
            }, value: $inventorySellSetDataModel.getAdress)
            NavigationLink(
                destination: TradingLocationSelection(usedBy: 4), tag: 2, selection:$inventorySellSetDataModel.navigationTag) {
                EmptyView()
            }.isDetailLink(false)
            CommonTextField(label: "受け渡し備考", placeholder: "例：17時以降での受け渡し希望", value: $inventorySellSetDataModel.remark)
            GotoOtherViewSelectField(label: "配達可能エリア", placeholder: "選択する", onClick: {
                inventorySellSetDataModel.navigationTag = 3
            }, value: $inventorySellSetDataModel.sellAdress)
            NavigationLink(
                destination: AreaSelection(usedBy: 2), tag: 3, selection:$inventorySellSetDataModel.navigationTag) {
                EmptyView()
            }.isDetailLink(false)
             */
            CommonTextField(label: "受け渡し方法", placeholder: "", value: $inventorySellSetDataModel.deliveryWay, disabled: true)
            CommonTextField(label: "重量（㎏）", placeholder: "", value: usedBy == 1 ? $inventoryDataModel.weightValue : $inventoryEditDataModel.weightValue, commabled: true, validationMessage: usedBy == 1 ? inventoryDataModel.weightMessage : inventoryEditDataModel.weightMessage)
                .keyboardType(.decimalPad)
            CommonTextField(label: "商品価格（円）/1缶辺り", placeholder: "", value: usedBy == 1 ? $inventoryDataModel.priceValue : $inventoryEditDataModel.priceValue, disabled: from != 1 ? false : true, commabled: true, additionalMessage: "出品価格は定価の半額以下が目安となります。", validationMessage: usedBy == 1 ? inventoryDataModel.priceMessage : inventoryEditDataModel.priceMessage)
                .keyboardType(.decimalPad)
            MultilineTextField(label: "商品説明", placeholder: "本文(15,000文字以内)： \n\n以下のような情報を記載してください。 \n・特徴 \n・状態 \n・注意点など", height: 285, value: usedBy == 1 ? $inventoryDataModel.specification : $inventoryEditDataModel.specification, validationMessage: usedBy == 1 ? inventoryDataModel.specificationMessage : inventoryEditDataModel.specificationMessage)
        }
    }
}
