//
//  OrderRegardDataModel.swift
//  PaintShare
//
//  Created by Lee on 2022/6/27.
//

import SwiftUI

class OrderRegardDataModel: ObservableObject {
    
    @Published var navigationTag: Int? = nil
    
    @Published var orderRegardValue: String = ""
    
    @Published var showUpdataNoti: Bool = false
    
    @Published var showWeightNoti: Bool = false
    
    @Published var showWeightErrorNoti: Bool = false
    
    @Published var showPicker: Bool = false
    
    @Published var showDatePicker: Bool = false
    
    @Published var payPickList: [PickItem] = [PickItem(key: 0, value: "未済"),PickItem(key: 2, value: "受け渡し済み")]
    
    @Published var pickList: [PickItem] = []
    
    @Published var pickListId: Int = 0
    
    @Published var payKey = -1
    
    @Published var payValue: String = ""
    
    @Published var selection: Int = -1
    
    @Published var id: Int = 0
    
    @Published var stauts: String = ""
    
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
    
    @Published var paintWeight: String = "" {
        didSet {
            weightMessage = ""
        }
    }
    
    @Published var paintPrice: String = ""
    
    @Published var useDate: String = ""
    
    @Published var inventoryNumber: String = ""
    
    @Published var expireDate: Date = Date()
    
    @Published var expireDateStr: String = ""
    
    @Published var updateNotiType: Int = 0  // 1date、2status
    
    @Published var paintId: Int = 0
        
    var paykeyDefault: Int = -1
    
    var materialImgKey: String?
    
    var updatedAt: UInt64 = 0
    
    @Published var weightMessage: String = ""
    
    func initData(item: OrderListItem, dialogsDataModel: DialogsDataModel){
        id = item.id
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
        paintWeight = "\(item.order.weight ?? 0)"
        paintPrice = "\(item.order.price ?? 0)"
        useDate = item.order.expirationDate ?? ""
        inventoryNumber = item.orderNo
        materialImgKey = item.order.materialImgKey
        updatedAt = item.user.updatedAt
        paintId = item.paintId
        expireDateStr = item.arrivalDate
        if item.deliveryStatus == 2{
            payValue = "受け渡し済み"
        }else{
            payValue = "未済"
        }
    }
    
    func setPackList(pickListId: Int){
        selection = payKey
        pickList = payPickList
    }
    
    func setPickValue(pickId: Int){
        payKey = pickId == -1 ? paykeyDefault : pickId
        payValue = getValueById(pickId: payKey,list: payPickList)
    }
    
    func getValueById(pickId: Int, list:[PickItem]) -> String{
        for item in list {
            if item.key == pickId{
                return item.value
            }
        }
        return ""
    }
    
    func regardWeight(dialogsDataModel: DialogsDataModel){
        let body = OrderWeightBody(orderId: id, weight: paintWeight)
        UrlUtils.postRequest(url:  UrlConstants.ORDER_CHANGE_ORDER_WEIGHT, body: body, dialogsDataModel: dialogsDataModel)
            .then{
                DispatchQueue.main.async {
                    
                }
            }
            .catch {
                error in
                if let validationError = error as? ValidationError {
                    if let weightError = validationError.errors["weight"] {
                        self.weightMessage = weightError
                        self.showWeightErrorNoti = true
                    }
                }
            }
    }
    
    func regardDate(dialogsDataModel: DialogsDataModel){
        let body = OrderRegardBody(id: id, arrivalDate: expireDateStr)
        UrlUtils.postRequest(url:  UrlConstants.ORDER_CHANGE_DELIVERY_STATUS, body: body, dialogsDataModel: dialogsDataModel)
            .then{
                DispatchQueue.main.async {
                    
                }
            }
    }
    
    func regard(dialogsDataModel: DialogsDataModel){
        let body = OrderRegardBody(id: id, deliveryStatus: "\(payKey)")
        UrlUtils.postRequest(url:  UrlConstants.ORDER_CHANGE_DELIVERY_STATUS, body: body, dialogsDataModel: dialogsDataModel)
            .then{
                DispatchQueue.main.async {
                    
                }
            }
    }
}
