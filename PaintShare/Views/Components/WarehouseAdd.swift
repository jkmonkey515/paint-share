//
//  WarehouseAdd.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/03.
//

import SwiftUI

struct WarehouseAdd: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var warehouseInfoChangeDataModel: WarehouseInfoChangeDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var warehouseDataModel: WarehouseDataModel
    
    @EnvironmentObject var mapSearchDataModel: MapSearchDataModel
    
    @EnvironmentObject var inventoryDataModel:InventoryDataModel
    
    var body: some View {
        
        ZStack {
            VStack(spacing:0){
                CommonHeader(title: warehouseInfoChangeDataModel.mode==0 ? "倉庫登録":"倉庫編集", showBackButton: true, showHamburgerButton: false,onBackClick: {
                    presentationMode.wrappedValue.dismiss()
                })
                
                ScrollView {
                    
                    ZStack {
                        VStack(spacing:45){
                            CommonTextField(label: "倉庫名", placeholder: "", required: true, value: $warehouseInfoChangeDataModel.warehouseName,validationMessage: warehouseInfoChangeDataModel.warehouseNameMessage)
                                .padding(.top,20)
                            
                            HStack(spacing:0){
                                CommonTextField(label: "郵便番号", placeholder: "",value: $warehouseInfoChangeDataModel.zipcode, showOptionalTag: true, validationMessage: warehouseInfoChangeDataModel.zipcodeMessage)
                                    .frame(width: 150)
                                    .padding(.leading,0)
                                
                                Text("地図から検索")//TradingLocationSelection
                                    .font(.regular11)
                                    .foregroundColor(.primary)
                                    .padding(.top,-22)
                                    .padding(.leading,-30)
                                    .onTapGesture {
                                        //mapSearchDataModel.searchPhrase = "\(warehouseInfoChangeDataModel.zipcode) \(warehouseInfoChangeDataModel.prefValue) \(warehouseInfoChangeDataModel.municipalitieName) \(warehouseInfoChangeDataModel.addressName)".trimmingCharacters(in: .whitespaces)
                                        warehouseInfoChangeDataModel.navigationTag = 1
                                    }
                                
                                NavigationLink(
                                    destination: TradingLocationSelection(usedBy: 1), tag: 1, selection:$warehouseInfoChangeDataModel.navigationTag) {
                                        EmptyView()
                                    }.isDetailLink(false)
                                
                                Spacer()
                            }
                            
                            HStack(spacing:0){
                                CommonSelectField(label: "都道府県", placeholder: "",onClick: {
                                    warehouseInfoChangeDataModel.prefKey = -1
                                    warehouseInfoChangeDataModel.showPrefPick = true
                                },value:$warehouseInfoChangeDataModel.prefValue)
                                .frame(width: 150)
                                .padding(.leading,0)
                                
                                OptionalLabel()
                                    .padding(.top,-25)
                                    .padding(.leading,-87)
                                
                                Spacer()
                            }
                            
                            CommonTextField(label: "市区町村", placeholder: "", value: $warehouseInfoChangeDataModel.municipalitieName, showOptionalTag: true, validationMessage:warehouseInfoChangeDataModel.municipalitieNameMessage )
                            CommonTextField(label: "番地", placeholder: "", value: $warehouseInfoChangeDataModel.addressName, showOptionalTag: true, validationMessage: warehouseInfoChangeDataModel.addressNameMessage)
                            
                            VStack{
                                CommonButton(text: "保存", width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                                    warehouseInfoChangeDataModel.saveWarehouse(dialogsDataModel: dialogsDataModel, warehouseDataModel: warehouseDataModel)
                                })
                                .padding(.top, 40)
                                .padding(.bottom, 16)
                                
                                if(warehouseInfoChangeDataModel.mode==1){
                                    CommonButton(text: "キャンセル", color: Color.caution, width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                                        presentationMode.wrappedValue.dismiss()
                                    })
                                    .padding(.bottom, 140)
                                }
                            }.padding(.bottom, 250)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                        
                    }
                }
                Spacer()
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            if warehouseInfoChangeDataModel.showPrefPick{
                VStack{
                    CommonPicker(selection:$warehouseInfoChangeDataModel.prefKey,pickList: warehouseInfoChangeDataModel.prefs,onCancel:{
                        warehouseInfoChangeDataModel.showPrefPick = false
                    },onCompleted: {
                        warehouseInfoChangeDataModel.setPrefValue()
                        warehouseInfoChangeDataModel.showPrefPick = false
                    })
                    if warehouseInfoChangeDataModel.addBottom {
                        Spacer(minLength: 80)
                    }
                }
            }
            MainViewModals()
            if (dialogsDataModel.showLoading) {
                ProgressView()
            }
        }
    }
}
