//
//  AreView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/05/30.
//

import SwiftUI

struct AreaView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var locationDataModel:LocationDataModel
    
    @EnvironmentObject var inventorySellSetDataModel:InventorySellSetDataModel
    
    @EnvironmentObject var inventoryDataModel:InventoryDataModel
    
    @EnvironmentObject var inventoryEditDataModel:InventoryEditDataModel
    
    @EnvironmentObject var inventorySearchDataModel: InventorySearchDataModel
    
    public var usedBy: Int//在庫登錄: 1、在庫検索: 2、検索条件設定: 3、
    
    var body: some View {
  
            ZStack{
            VStack {
                VStack {
                    List{
                    ForEach(locationDataModel.areaCategory, id: \.self) { area in
                        AreaListTitle(title: area.name, tag: 0, type: -1, code: -1)
                            .listRowBackground(Color(hex: "#F1F1F1"))

                        
                        if(area.prefectures.count > 1){
                            AreaListTitle(title: area.name+"のすべて", tag: 1,  type: 1, code: area.code)
                        }
                        
                        ForEach(area.prefectures, id: \.self) { pref in
                            
                            HStack{
                                AreaListTitle(title: pref.name, tag: 1, type: 2, code: pref.code)
                                
                                Spacer()
                                
                                Image(systemName: locationDataModel.codeExpandMap[pref.code]! ? "chevron.down" : "chevron.up")
                                    .padding(.trailing)
                                    .onTapGesture {
                                        locationDataModel.codeExpandMap[pref.code] = !locationDataModel.codeExpandMap[pref.code]!
                                    }
                            }
                            
                            if(locationDataModel.codeExpandMap[pref.code]!){
                                ForEach(pref.cities,id: \.self){ machi in
                                    AreaListTitle(title:machi.name, tag: 2, type: 3, code: machi.code)
                                    
                                }.padding(.leading,17)
                            }
                        }
                        
                    }
                    }.listStyle(.plain)
                        .padding(.bottom)
                    
                }
                
                
                
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 85)
                    
                    HStack(spacing:0){
                        GeneralButton(onClick: {
                            locationDataModel.clearCheck()
                        }, label: {
                            Text("クリア")
                                .font(.regular18)
                                .foregroundColor(.white)
                                .frame(width: 155,height: 37)
                            
                        })
                            .background(Color(hex: "#E38F97"))
                            .cornerRadius(5)
                            .shadow(color: Color(hex: "000000").opacity(0.16), radius: 3, x: 0.0, y: 3)
                        
                        GeneralButton(onClick: {
                            
                            if (usedBy == 1) {
                                inventoryDataModel.goodPlace = locationDataModel.checkString
                                inventoryDataModel.goodPlaceCodeArray = locationDataModel.checkCodeArray
                                inventorySellSetDataModel.navigationTag = nil
                            }else if (usedBy == 2){
                                inventoryEditDataModel.goodPlace = locationDataModel.checkString
                                inventoryEditDataModel.goodPlaceCodeArray = locationDataModel.checkCodeArray
                                inventorySellSetDataModel.navigationTag = nil
                            }else if (usedBy == 3){
                                inventorySearchDataModel.searchAdress = locationDataModel.checkString
                                inventorySearchDataModel.searchCodeArray = locationDataModel.checkCodeArray
                                inventorySearchDataModel.navigationTag = nil
                            }
                            
                        }, label: {
                            Text("決定")
                                .font(.regular18)
                                .foregroundColor(.white)
                                .frame(width: 155,height: 37)
                            
                        })
                            .background(Color(hex: "56B8C4"))
                            .cornerRadius(5)
                            .shadow(color: Color(hex: "000000").opacity(0.16), radius: 3, x: 0.0, y: 3)
                            .padding(.leading,25)
                    }
                    .padding(.bottom)
                }
            }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
    }
}
