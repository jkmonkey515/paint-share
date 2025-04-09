//
//  InventorySellSetDataModel.swift
//  PaintShare
//
//  Created by Lee on 2022/6/10.
//

import SwiftUI

class InventorySellSetDataModel:ObservableObject{
    
    @Published var navigationTag: Int? = nil
    
    @Published var addBottom: Bool = false
    
    @Published var showPicker: Bool = false
    
    @Published var payPickList: [PickItem] = [PickItem(key: 0, value: "クレジットカード"),PickItem(key: 1, value: "現金手渡し")]
    
    @Published var payKey = -1
    
    @Published var payValue: String = ""
    
    @Published var sendPickList: [PickItem] = [PickItem(key: 0, value: "取りに来てもらう"),PickItem(key: 1, value: "届けにいく"),PickItem(key: 2, value: "配送")]
    
    @Published var sendKey = -1
    
    @Published var sendValue: String = ""
    
    @Published var pickListId: Int = 0
    
    @Published var selection: Int = -1
    
    @Published var pickList: [PickItem] = []
    
    @Published var sellAdress: String = ""
    
    @Published var getAdress: String = ""
    
    @Published var remark: String = ""
    
    @Published var sendAdress: String = ""
    
    @Published var payWay: String = "クレジットカード"
    
    @Published var deliveryWay: String = "手渡し"
    
    @Published var price: String = ""
    
    var paykeyDefault: Int = -1
    
    var sendkeyDefault: Int = -1
    
    func setPackList(pickListId: Int){
        switch pickListId {
        case 0:
            selection = payKey
            pickList = payPickList
            break
        case 1:
            selection = sendKey
            pickList = sendPickList
            break
        default:
            pickList = sendPickList
        }
    }
    
    func setPickValue(pickId: Int){
        switch pickListId {
        case 0:
            payKey = pickId == -1 ? paykeyDefault : pickId
            payValue = getValueById(pickId: payKey,list: payPickList)
            break
        case 1:
            sendKey = pickId == -1 ? sendkeyDefault : pickId
            sendValue = getValueById(pickId: sendKey,list: sendPickList)
            break
        default:
            break
        }
    }
    
    func getValueById(pickId: Int, list:[PickItem]) -> String{
        for item in list {
            if item.key == pickId{
                return item.value
            }
        }
        return ""
    }
    func getAddressByCoordinate(lat: Double, lng: Double, dialogsDataModel: DialogsDataModel) {
        UrlUtils.getRequest(url: UrlConstants.THIRD_PARTY_GET_ADDRESS_BY_COORDINATE+"?lat=\(lat)&lng=\(lng)", type: GeocodingAddressDto.self, dialogsDataModel: dialogsDataModel)
            .then{
                response in
                DispatchQueue.main.async {
                    self.sellAdress = (response?.prefecture ?? "")+(response?.city ?? "")
                }
            }
    }
}
