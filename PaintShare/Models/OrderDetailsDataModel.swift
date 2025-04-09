//
//  OrderDetailsDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/27.
//

import SwiftUI

class OrderDetailsDataModel: ObservableObject {
    
    @Published var lotNumber: String = ""
    
    @Published var groupName: String = ""
    
    @Published var goodName: String = ""
    
    @Published var warehouseName: String = ""
    
    @Published var makerName: String = ""
    
    @Published var useCategoryValue: String = ""
    
    @Published var colorNumber: String = "#FFFFFF"
    
    @Published var colorCode: String = ""
    
    @Published var colorName: String = ""
    
    @Published var paintNum: String = ""
    
    @Published var paintWeight: String = ""
    
    @Published var paintPrice: String = ""
    
    @Published var useDate: String = ""
    
    @Published var inventoryNumber: String = ""
        
    @Published var arrivalDate: String = ""
    
    @Published var paintPriceNum: String = ""
    
    @Published var deliveryStatus: Int = 0
    
    var profileImgKey: String?
    
    var materialImgKey: String?
    
    var updatedAt: UInt64 = 0
    
    @Published var generatedUserId: String = ""
    
    func initData(item: OrderListItem, dialogsDataModel: DialogsDataModel){
        lotNumber = item.order.lotNumber
        groupName = item.order.groupName
        goodName = item.order.paintName
        warehouseName = item.order.warehouseName
        makerName = item.order.makerName
        useCategoryValue = item.order.useCategoryName ?? ""
        colorNumber = ""
        colorCode = item.order.colorCode ?? "該当なし"
        colorName = item.order.colorName ?? "該当なし"
        paintNum = "\(item.number)"
        paintWeight = item.order.weight == nil ? "計量中..." : "\(item.order.weight ?? 0)"
        paintPrice = "\(item.order.price ?? 0)"
        useDate = item.order.expirationDate ?? ""
        inventoryNumber = item.orderNo
        profileImgKey = item.user.profileImgKey
        materialImgKey = item.order.materialImgKey
        updatedAt = item.user.updatedAt
        generatedUserId = item.user.generatedUserId
        arrivalDate = item.arrivalDate
        paintPriceNum =  paintPrice.filter{$0 != ","}
        deliveryStatus = item.deliveryStatus
    }
    
}

