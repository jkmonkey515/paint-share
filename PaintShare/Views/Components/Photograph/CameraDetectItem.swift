//
//  CameraDetectItem.swift
//  PaintShare
//
//  Created by Lee on 2022/7/5.
//

import SwiftUI

struct CameraDetectItem: View {
        
    @EnvironmentObject var cameraDetectDataModel: CameraDetectDataModel
    
    @EnvironmentObject var inventoryDataModel: InventoryDataModel
    
    var type: Int = 0
    
    var num: Int = 0
    
    var cameraItem: String = ""
    
    var body: some View {
        HStack{
            if type == 1 {
                Image(systemName: cameraItem == inventoryDataModel.makerValue
                      ? "checkmark.square.fill"
                      : "square")
                    .foregroundColor(Color(hex: cameraItem == "" ? "56B8C4" : "B2B2B2" ))
                    .onTapGesture {
                        if inventoryDataModel.makerValue == cameraItem {
                            inventoryDataModel.makerValue = ""
                            inventoryDataModel.makerkey = -1
                            inventoryDataModel.goodsNameValue = ""
                            inventoryDataModel.goodsNameKey = -1
                        }else{
                            inventoryDataModel.makerValue = cameraItem
                            let dto = cameraDetectDataModel.makerDtos[num] as! CameraMakersDto
                            inventoryDataModel.makerkey = dto.id
                        }
                    }
            }else if type == 2 {
                Image(systemName: cameraItem == inventoryDataModel.goodsNameValue
                      ? "checkmark.square.fill"
                      : "square")
                    .foregroundColor(Color(hex: cameraItem == "" ? "56B8C4" : "B2B2B2" ))
                    .onTapGesture {
                        if cameraItem.contains(inventoryDataModel.makerValue) {
                            if inventoryDataModel.goodsNameValue == cameraItem {
                                inventoryDataModel.goodsNameValue = ""
                                inventoryDataModel.goodsNameKey = -1
                            }else{
                                inventoryDataModel.goodsNameValue = cameraItem
                                let dto = cameraDetectDataModel.nameDtos[num] as! CameraGoodsNamesDto
                                inventoryDataModel.goodsNameKey = dto.goodsName.id
                            }
                        }
                    }
            }else if type == 3 {
                Image(systemName: cameraItem == inventoryDataModel.useCategoryValue
                      ? "checkmark.square.fill"
                      : "square")
                    .foregroundColor(Color(hex: cameraItem == "" ? "56B8C4" : "B2B2B2" ))
                    .onTapGesture {
                        if inventoryDataModel.useCategoryValue == cameraItem {
                            inventoryDataModel.useCategoryValue = ""
                            inventoryDataModel.useCategorykey = -1
                        }else{
                            inventoryDataModel.useCategoryValue = cameraItem
                            let dto = cameraDetectDataModel.useDtos[num] as! CameraUseCategoriesDto
                            inventoryDataModel.useCategorykey = dto.id
                        }
                    }
            }else if type == 4 {
                Image(systemName: cameraItem == inventoryDataModel.colorNumber
                      ? "checkmark.square.fill"
                      : "square")
                    .foregroundColor(Color(hex: cameraItem == "" ? "56B8C4" : "B2B2B2" ))
                    .onTapGesture {
                        if inventoryDataModel.colorNumber == cameraItem {
                            inventoryDataModel.colorNumber = ""
                            inventoryDataModel.colorNumberId = -1
                        }else{
                            inventoryDataModel.colorNumber = cameraItem
                            let dto = cameraDetectDataModel.colorDtos[num] as! CameraColorsDto
                            inventoryDataModel.colorNumberId = dto.id
                            inventoryDataModel.colorCode = dto.colorCode
                        }
                    }
            }
            if type == 2 {
                HStack {
                    Text(cameraItem)
                        .font(.regular14)
                        .foregroundColor(cameraItem.contains(inventoryDataModel.makerValue) == true ? .mainText : .lightText)
                        .lineLimit(1)
                    Spacer()
                }.frame(maxWidth: .infinity)
            }else if type == 4 {
                HStack {
                    Text(cameraItem)
                        .font(.regular14)
                        .foregroundColor(cameraItem.contains(inventoryDataModel.makerValue) == true || cameraItem.contains("日塗工") ? .mainText : .lightText)
                        .lineLimit(1)
                    Spacer()
                }.frame(maxWidth: .infinity)
            }else{
                HStack {
                    Text(cameraItem)
                        .font(.regular14)
                        .foregroundColor(.mainText)
                        .lineLimit(1)
                    Spacer()
                }.frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 21)
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
}
