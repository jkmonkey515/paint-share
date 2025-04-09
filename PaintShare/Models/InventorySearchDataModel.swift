//
//  InventorySearchDataModel.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/04/23.
//

import SwiftUI

class InventorySearchDataModel: ObservableObject {
    
    @Published var navigationTag: Int? = nil
    
    @Published var checked: Bool = true
    
    @Published var searchAdress: String = ""
        
    @Published var searchCodeArray: [String] = []
        
    // @Published var inventoryGroupSearchItems: [InventoryGroupSearchItemDto] = []
    
    @Published var displayInventoryItems: [InventorySearchItem] = []
    
    @Published var page = 0
    
    @Published var hasNext = false
    
    var searchInProgress: Bool = false
    
    // search
    
    @Published var searchPhrase: String = ""
    
    @Published var showRefreshingIcon: Bool = false
    
    @Published var goodsName: String = ""
    
    @Published var standardId: Int = -1
    
    @Published var standardName: String = "_"
    
    @Published var colorNumberId: Int = -1
    
    @Published var colorNumber: String = ""
    
    @Published var colorCode: String = "#FFFFFF"
    
    @Published var useCategorykey: Int = -1
    
    @Published var useCategoryValue: String = ""
    
    @Published var makerkey: Int = -1
    
    @Published var makerValue: String = ""
    
    @Published var expireDateTypeKey: Int = -1
    
    @Published var expireDateTypeValue: String = ""
    
    @Published var groupTypeKey: Int = 0
    
    @Published var groupTypeValue: String = "全てのグループ"
    
    var makerkeyDefault: Int = -1
    
    var useCategorykeyDefault: Int = -1
    
    var groupTypeKeyDefault: Int = 0
    
    var expireDateTypeKeyDefault: Int = 0
    
    // picker用
    @Published var showPicker: Bool = false
    
    @Published var pickListId: Int = 0
    
    @Published var selection: Int = -1
    
    @Published var pickList: [PickItem] = []
    
    @Published var useCategorPickList: [PickItem] = []
    
    @Published var makerPickList: [PickItem] = []
    
    @Published var expireDateTypeList: [PickItem] = []
    
    @Published var groupTypeList: [PickItem] = []
    
    @Published var sharedGroupList: [Int] = []
    
    @Published var useCategorMaster: [UseCategoryDto] = []
    
    @Published var makerDtoMaster: [MakerDto] = []
    
    @Published var otherColorName: String = ""
    
    @Published var colorFlag: Bool = false
    
    func reset() {
        displayInventoryItems = []
        page = 0
        hasNext = false
        searchInProgress = false
        showRefreshingIcon = false
        navigationTag = nil
    }
    
    func clear(){
        goodsName = ""
        standardId = -1
        standardName = "_"
        colorNumberId = -1
        colorNumber = ""
        colorCode = "#FFFFFF"
        useCategorykey = -1
        useCategoryValue = ""
        makerkey = -1
        makerValue = ""
        expireDateTypeKey = -1
        expireDateTypeValue = ""
        groupTypeKey = 0
        groupTypeValue = "全てのグループ"
        searchAdress = ""
        checked = true
        otherColorName=""
        colorFlag = false
    }
    
    func searchFromZeroPage(dialogsDataModel: DialogsDataModel) {
        self.page = 0
        self.hasNext = false
        self.search(dialogsDataModel: dialogsDataModel)
    }
    
    func loadMore(dialogsDataModel: DialogsDataModel) {
        debugPrintLog(message:"inventory loading more appear")
        if hasNext {
            page = page + 1
            search(dialogsDataModel: dialogsDataModel)
        }
    }
    
    func search(dialogsDataModel: DialogsDataModel){
        if self.searchInProgress {
            if self.page > 0 {
                self.page = self.page - 1
            }
            return
        }
        self.searchInProgress = true
        if (self.page == 0) {
            self.displayInventoryItems = []
            self.hasNext = false
        }
        // データ取得
        // swiftui list reload bug のため
        let delay: Double = self.page == 0 ? 0.2 : 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UrlUtils.getRequest(url: self.createSearchParam(), type: InventorySearchPage.self, dialogsDataModel: dialogsDataModel)
                .then {
                    result in
                    if result != nil {
                        if (result!.content.count == 0) {
                            if self.page > 0 {
                                self.page = self.page - 1
                            }
                        }
                        
                        self.hasNext = result!.hasNext
                        self.displayInventoryItems.append(contentsOf: result!.content)
                    } else {
                        if self.page > 0 {
                            self.page = self.page - 1
                        }
                    }
                }
                .always {
                    self.searchInProgress = false
                    self.showRefreshingIcon = false
                }
        }
    }
    
    func createSearchParam() -> String{
        var url:String = UrlConstants.PAINT_SEARCH_WITH_PAGING + "?"
        if makerkey != -1{
            url += "makerId=\(makerkey)&"
        }
        if useCategorykey != -1{
            url += "useCategoryId=\(useCategorykey)&"
        }
        if goodsName.count > 0{
            let percentEncoded = self.goodsName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            url += "goodsName=\(percentEncoded ?? "")&"
        }
        if (colorFlag) {
            url += "otherColorName=\(otherColorName)&"
        }
        else
        {
            if colorNumberId != -1{
                url += "colorNumberId=\(colorNumberId)&"
            }
        }
        if standardId != -1{
            url += "standardId=\(standardId)&"
        }
        if groupTypeKey != -1{
            url += "ownedBy=\(groupTypeKey)&"
        }
        if expireDateTypeKey != -1{
            url += "expireDateType=\(expireDateTypeKey)&"
        }
        if searchAdress != ""{
            let percentEncoded = self.searchAdress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            url += "place=\(percentEncoded ?? "")&"
        }
        if checked == true{
            url += "nonRelatedFlag=\(checked)&"
        }
        if searchPhrase != ""{
            let percentEncoded = self.searchPhrase.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            url += "quickSearch=\(percentEncoded ?? "")&"
        }
        if !displayInventoryItems.isEmpty {
            url += "lastItemGroupId=\(self.displayInventoryItems.last!.ownedBy.id)&lastItemMakerId=\(self.displayInventoryItems.last!.maker.id)&"
        }
        
        url += "page=\(self.page)"
        return url;
    }
    
    func initData(dialogsDataModel: DialogsDataModel) {
        // データ 取得
        searchFromZeroPage(dialogsDataModel: dialogsDataModel)
        // メーカーマスタ 取得
        UrlUtils.getRequest(url: UrlConstants.MST_MAKERS, type: [MakerDto].self, dialogsDataModel: dialogsDataModel)
            .then {
                makerDtoMaster in
                self.makerPickList = []
                for makerItem in makerDtoMaster! {
                    if self.makerkeyDefault == -1 {
                        self.makerkeyDefault = makerItem.id
                    }
                    let pick = PickItem(key: makerItem.id,value: makerItem.name)
                    self.makerPickList.append(pick)
                }
            }
        
        // 用途区分マスタ 取得
        UrlUtils.getRequest(url: UrlConstants.MST_USE_CATEGORIES, type: [UseCategoryDto].self, dialogsDataModel: dialogsDataModel)
            .then {
                useCategorMaster in
                self.useCategorPickList = []
                for useCategoryItem in useCategorMaster! {
                    if self.useCategorykeyDefault == -1 {
                        self.useCategorykeyDefault = useCategoryItem.id
                    }
                    let pick = PickItem(key: useCategoryItem.id,value: useCategoryItem.name)
                    self.useCategorPickList.append(pick)
                }
            }
        // 関連グループ
        UrlUtils.getRequest(url: UrlConstants.PAINT_GET_SEARCH_RELATION_GROUP_LIST, type: GroupSearchRelationItemDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                result in
                self.groupTypeList = []
                let ownedGroupList:[GroupDto] = result!.ownedGroupList
                let joinGroupList:[GroupDto] = result!.joinGroupList
                let sharingGroupList:[GroupDto] = result!.sharingGroupList
                let groupTypePick = PickItem(key: 0,value: "全てのグループ")
                let groupTypePick1 = PickItem(key: -2,value: "オーナー・メンバーグループ")
                let groupTypePick2 = PickItem(key: -3,value: "フレンドグループ")
                self.groupTypeList.append(groupTypePick)
                if (ownedGroupList.count > 0 || joinGroupList.count > 0) {
                    self.groupTypeList.append(groupTypePick1)
                }
                if (sharingGroupList.count > 0) {
                    self.groupTypeList.append(groupTypePick2)
                }
                
                if (ownedGroupList.count > 0) {
                    for groupitem in ownedGroupList {
                        let pick = PickItem(key: groupitem.id,value: groupitem.groupName)
                        self.groupTypeList.append(pick)
                        self.sharedGroupList.append(groupitem.id)
                    }
                }
                if (joinGroupList.count > 0) {
                    for groupitem in joinGroupList {
                        let pick = PickItem(key: groupitem.id,value: groupitem.groupName)
                        self.groupTypeList.append(pick)
                        self.sharedGroupList.append(groupitem.id)
                    }
                }
                if (sharingGroupList.count > 0) {
                    for groupitem in sharingGroupList {
                        let pick = PickItem(key: groupitem.id,value: groupitem.groupName)
                        self.groupTypeList.append(pick)
                    }
                }
            }
    }
    
    
    init() {
        // 使用期限
        let expireDatePick1 = PickItem(key: 0,value: "期限内の在庫のみ")
        let expireDatePick2 = PickItem(key: 1,value: "期限切れの在庫のみ")
        let expireDatePick3 = PickItem(key: 2,value: "期限が近い在庫のみ")
        let expireDatePick4 = PickItem(key: 3,value: "全て")
        expireDateTypeList = []
        expireDateTypeList.append(expireDatePick1)
        expireDateTypeList.append(expireDatePick2)
        expireDateTypeList.append(expireDatePick3)
        expireDateTypeList.append(expireDatePick4)
        
        setPackList(pickListId: pickListId)
    }
    
    // picker用list初期化
    func setPackList(pickListId: Int){
        switch pickListId {
        case 0:
            selection = useCategorykey
            pickList = useCategorPickList
            break
        case 1:
            selection = makerkey
            pickList = makerPickList
            break
        case 2:
            selection = expireDateTypeKey
            pickList = expireDateTypeList
            break
        case 3:
            selection = groupTypeKey
            pickList = groupTypeList
            break
        default:
            pickList = useCategorPickList
        }
    }
    
    func setPickValue(pickId: Int){
        switch pickListId {
        case 0:
            useCategorykey = pickId == -1 ? useCategorykeyDefault : pickId
            useCategoryValue = getValueById(pickId: useCategorykey,list: useCategorPickList)
            break
        case 1:
            makerkey = pickId == -1 ? makerkeyDefault : pickId
            makerValue = getValueById(pickId: makerkey,list: makerPickList)
            break
        case 2:
            expireDateTypeKey = pickId == -1 ? expireDateTypeKeyDefault : pickId
            expireDateTypeValue = getValueById(pickId: expireDateTypeKey,list: expireDateTypeList)
            break
        case 3:
            groupTypeKey = pickId == -1 ? groupTypeKeyDefault : pickId
            groupTypeValue = getValueById(pickId: groupTypeKey,list: groupTypeList)
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
                    self.searchAdress = (response?.prefecture ?? "")+(response?.city ?? "")
                }
            }
    }
}
