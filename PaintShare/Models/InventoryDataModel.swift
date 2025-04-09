//
//  InventoryDataModel.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/05/05.
//

import SwiftUI

class InventoryDataModel: ObservableObject {
    
    @Published var selectedSell: Int = 0
    
    @Published var priceValue: String = "" {
        didSet {
            priceMessage = ""
            if priceValue.isFloat && priceValue.contains(".") && priceValue.last != "."{
                priceValue = String(lroundf(Float(priceValue) ?? 0))
            }
        }
    }
    
    @Published var weightValue: String = "" {
        didSet {
            weightMessage = ""
        }
    }
    
    @Published var specification: String = ""{
        didSet {
            specificationMessage = ""
        }
    }
    
    @Published var goodPlace: String = ""
        
    @Published var goodPlaceCodeArray: [String] = []
    
    @Published var navigationTag: Int? = nil
    
    @Published var useCategorykey: Int = -1 {
        didSet {
            useCategoryIdMessage = ""
        }
    }
    
    var useCategorykeyDefault: Int = -1
    
    @Published var useCategoryValue: String = ""
    
    @Published var makerkey: Int = -1 {
        didSet {
            makerIdMessage = ""
        }
    }
    
    var adresskeyDefault: Int = -1
    
    @Published var adresskey: Int = -1 {
        didSet {
            adressIdMessage = ""
        }
    }
    
    var makerkeyDefault: Int = -1
    
    @Published var makerValue: String = ""
    
    @Published var adressValue: String = ""
    
    @Published var goodsNameKey: Int = -1 {
        didSet {
            goodsNameIdMessage = ""
        }
    }
    
    @Published var goodsNameValue: String = ""
    
    @Published var standardId: Int = 0
    
    @Published var standardName: String = "_"
    
    @Published var colorNumberId: Int = -1
    
    @Published var colorNumber: String = ""
    
    @Published var colorCode: String = "#FFFFFF"
    
    @Published var logo: UIImage? = Constants.imageHolderUIImage!
    
    @Published var amount: String = "0.0" {
        didSet {
            goodsNameIdMessage = ""
        }
    }
    
    @Published var amountInteger: Int = 0
    
    @Published var amountDecimal: Int = 0
    
    @Published var expireDate: Date = Date()
    
    @Published var expireDateStr: String = ""
    
    @Published var lotNumber: String = "" {
        didSet {
            lotNumberMessage = ""
        }
    }
    
    @Published var inventoryPublic: Bool = false {
        didSet {
            goodsPublicMessage = ""
            if inventoryPublic == false {
                sellPublic = false
            }
        }
    }
    
    @Published var sellPublic: Bool = false {
        didSet {
            if sellPublic == true {
                inventoryPublic = true
            }
        }
    }
    
    @Published var groupKey: Int = -1 {
        didSet {
            ownedByIdMessage = ""
        }
    }
    
    var groupKeyDefault: Int = -1
    
    @Published var groupValue: String = ""
    
    // picker用
    @Published var showPicker: Bool = false
    
    @Published var showDatePicker: Bool = false
    
    @Published var showAmountPicker: Bool = false
    
    @Published var pickListId: Int = 0
    
    @Published var selection: Int = -1
    
    @Published var pickList: [PickItem] = []
    
    @Published var useCategorPickList: [PickItem] = []
    
    @Published var makerPickList: [PickItem] = []
    
    @Published var goodsNamePickList: [PickItem] = []
    
    @Published var groupPickList: [PickItem] = []
    
    @Published var adressPickList: [PickItem] = []
    
    var goodsNameMaster: [GoodsNameDto] = []
    
    @Published var showNewConfirmDialog: Bool = false
    
    @Published var showRegisteredDialog: Bool = false
    
    // validation messages
    @Published var ownedByIdMessage: String = ""
    
    @Published var makerIdMessage: String = ""
    
    @Published var adressIdMessage: String = ""
    
    @Published var useCategoryIdMessage: String = ""
    
    @Published var goodsNameIdMessage: String = ""
    
    @Published var amountMessage: String = ""
    
    @Published var lotNumberMessage: String = ""
    
    @Published var goodsPublicMessage: String = ""
    
    @Published var approveStatus: String = "0"
    
    @Published var weightMessage: String = ""

    @Published var priceMessage: String = ""
    
    @Published var colorMessage: String = ""
    
    @Published var specificationMessage: String = ""
    
    @Published var showNeedConfirm: Bool = false
    
    @Published var selectGroupApproveStatus: Int = 0
    
    @Published var showPleaseRegisterWarehouseDialog: Bool = false
    
    @Published var showAskGroupOwnerToRegisterWarehouseDialog: Bool = false
    
    @Published var colorFlag: Bool = false
    
    @Published var otherColorName: String = ""
    
    func reset(){
        useCategorykey = -1
        useCategoryValue = ""
        makerkey = -1
        makerValue = ""
        goodsNameKey = -1
        goodsNameValue = ""
        standardId = 0
        standardName = "_"
        colorNumberId = -1
        colorNumber = ""
        colorCode = "#FFFFFF"
        logo = Constants.imageHolderUIImage!
        amount = "0.0"
        amountInteger = 0
        amountDecimal = 0
        expireDate = Date()
        expireDateStr = ""
        lotNumber = ""
        inventoryPublic = false
        sellPublic = false
        groupKey = -1
        groupKeyDefault = -1
        groupValue = ""
        adresskey = -1
        adresskeyDefault = -1
        adressValue = ""
        showNewConfirmDialog = false
        weightValue = ""
        priceValue = ""
        specification = ""
        goodPlace = ""
        goodPlaceCodeArray = []
        showRegisteredDialog = false
        colorFlag = false
        otherColorName = ""
    }
    
    func saveAndUploadImage(dialogsDataModel: DialogsDataModel, mainViewDataModel: MainViewDataModel) {
        if self.logo != Constants.imageHolderUIImage! {
            let imageData = self.logo!.jpegData(compressionQuality: 0.6)!
            let request = MultipartFormDataRequest(url: URL(string: UrlConstants.FILE_UPLOAD_IMAGE)!)
            request.addDataField(named: "file", data: imageData, mimeType: "image/jpeg")
            
            UrlUtils.imgUploadRequest(request: request, dialogsDataModel: dialogsDataModel)
                .then {
                    dataString in
                    DispatchQueue.main.async {
                        self.save(imgKey: dataString, dialogsDataModel: dialogsDataModel, mainViewDataModel: mainViewDataModel)
                    }
                }
        } else {
            self.save(imgKey: nil, dialogsDataModel: dialogsDataModel, mainViewDataModel: mainViewDataModel)
        }
        if groupKey != mainViewDataModel.loggedInUserGroup?.id && selectGroupApproveStatus != 0 {
            self.needConfirm()
        }
    }
    
    func save(imgKey: String?, dialogsDataModel: DialogsDataModel, mainViewDataModel: MainViewDataModel){
        var validColor: Bool = false;
        if (colorFlag) {
            if (otherColorName != ""){
                validColor = true;
            }
        }
        else {
            if (colorNumberId != -1){
                validColor = true;
            }
        }
        let body = InventoryBody(ownedById: groupKey == -1 ? nil : groupKey , makerId: makerkey == -1 ? nil : makerkey, useCategoryId: useCategorykey == -1 ? nil : useCategorykey, goodsNameId: goodsNameKey == -1 ? nil : goodsNameKey, standardId: standardId, colorNumberId: colorFlag ? -1 : colorNumberId,otherColorName: colorFlag ? otherColorName : "", isColor: validColor ? true : nil, materialImgKey: imgKey, amount: Double(amount)!, expireDate: expireDateStr, lotNumber: lotNumber, goodsPublic: inventoryPublic ? 1 : 0, goodsNameName: goodsNameValue, price: priceValue.filter{$0 != ","}, weight: weightValue, specification: specification, goodsPlace: goodPlaceCodeArray.count == 0 ? goodPlace : nil, goodsPlaceCodes: goodPlaceCodeArray, approveStatus: approveStatus, saleFlag: sellPublic ? 1 : 0, warehouseId: adresskey == -1 ? nil : adresskey)
        
        UrlUtils.postRequest(url: UrlConstants.PAINT_NEW, body: body, dialogsDataModel: dialogsDataModel)
            .then {
                DispatchQueue.main.async {
                    mainViewDataModel.selectedTab = 1
                    self.showRegisteredDialog = true
                  //  self.reset()
                }
            }
            .catch {
                error in
                if let validationError = error as? ValidationError {
                    if let ownedByIdError = validationError.errors["ownedById"] {
                        self.ownedByIdMessage = ownedByIdError
                    }
                    if let makerIdError = validationError.errors["makerId"] {
                        self.makerIdMessage = makerIdError
                    }
                    if let useCategoryIdError = validationError.errors["useCategoryId"] {
                        self.useCategoryIdMessage = useCategoryIdError
                    }
                    if let goodsNameIdError = validationError.errors["goodsNameName"] {
                        self.goodsNameIdMessage = goodsNameIdError
                    }
                    if let amountError = validationError.errors["amount"] {
                        self.amountMessage = amountError
                    }
                    if let lotNumberError = validationError.errors["lotNumber"] {
                        self.lotNumberMessage = lotNumberError
                    }
                    if let goodsPublicError = validationError.errors["goodsPublic"] {
                        self.goodsPublicMessage = goodsPublicError
                    }
                    if let weightError = validationError.errors["weight"] {
                        self.weightMessage = weightError
                    }
                    if let priceError = validationError.errors["price"] {
                        self.priceMessage = priceError
                    }
                    if let colorError = validationError.errors["isColor"] {
                        self.colorMessage = colorError
                    }
                    if let specificationError = validationError.errors["specification"] {
                        self.specificationMessage = specificationError
                    }
                }
            }
    }
    
    func initData(dialogsDataModel: DialogsDataModel, mainViewDataModel: MainViewDataModel) {
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
        
        // 所属グループ
        UrlUtils.getRequest(url: UrlConstants.PAINT_GET_GROUP_LIST, type: [GroupDto].self, dialogsDataModel: dialogsDataModel)
            .then {
                groupDtoList in
                self.groupPickList = []
                for groupitem in groupDtoList! {
                    if self.groupKeyDefault == -1 {
                        self.groupKeyDefault = groupitem.id
                        self.groupKey = groupitem.id
                        self.groupValue = groupitem.groupName
                        self.getAdress(groupId: groupitem.id, dialogsDataModel: dialogsDataModel, mainViewDataModel: mainViewDataModel)
                        self.selectGroupApproveStatus = 0
                    }
                    let pick = PickItem(key: groupitem.id,value: groupitem.groupName,determine: groupitem.groupApproveStatus)
                    self.groupPickList.append(pick)
                }
            }
    }
    
    // picker用list初期化
    func setPackList(pickListId: Int){
        switch pickListId {
        case 0:
            selection = makerkey
            pickList = makerPickList
            break
        case 1:
            selection = useCategorykey
            pickList = useCategorPickList
            break
        case 2:
            selection = goodsNameKey
            pickList = goodsNamePickList
            break
        case 3:
            selection = groupKey
            pickList = groupPickList
            break
        case 4:
            selection = adresskey
            pickList = adressPickList
            break
        default:
            pickList = useCategorPickList
        }
    }
    
    func setPickValue(pickId: Int, dialogsDataModel: DialogsDataModel, mainViewDataModel: MainViewDataModel){
        switch pickListId {
        case 0:
            makerkey = pickId == -1 ? makerkeyDefault : pickId
            makerValue = getValueById(pickId: makerkey,list: makerPickList)
            break
        case 1:
            useCategorykey = pickId == -1 ? useCategorykeyDefault : pickId
            useCategoryValue = getValueById(pickId: useCategorykey,list: useCategorPickList)
            break
        case 3:
            groupKey = pickId == -1 ? groupKeyDefault : pickId
            groupValue = getValueById(pickId: groupKey,list: groupPickList)
            for item in groupPickList {
                if item.key == groupKey{
                    selectGroupApproveStatus = item.determine ?? 0
                    print(selectGroupApproveStatus)
                }
            }
            self.getAdress(groupId: groupKey, dialogsDataModel: dialogsDataModel, mainViewDataModel: mainViewDataModel)
            break
        case 4:
            adresskey = pickId == -1 ? adresskeyDefault : pickId
            adressValue = getValueById(pickId: adresskey,list: adressPickList)
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
    
    func setAmount(amountInteger: Int,amountDecimal: Int){
        amount = String(amountInteger) + "." + String(amountDecimal)
    }
    
    func getAdress(groupId: Int, dialogsDataModel: DialogsDataModel, mainViewDataModel: MainViewDataModel){
        // 倉庫
        UrlUtils.getRequest(url: UrlConstants.WAREHOUSE_SEARCH_WAREHOUSEDTO+"/\(groupId)", type: [WarehouseDto].self, dialogsDataModel: dialogsDataModel)
            .then {
                warehouseDtoList in
                self.adressPickList = []
                self.adresskeyDefault = -1
                self.adresskey = -1
                self.adressValue = ""
                for warehouseitem in warehouseDtoList! {
                    if self.adresskeyDefault == -1 {
                        self.adresskeyDefault = warehouseitem.id
                        self.adresskey = warehouseitem.id
                        self.adressValue = warehouseitem.name
                    }
                    let pick = PickItem(key: warehouseitem.id,value: warehouseitem.name)
                    self.adressPickList.append(pick)
                }
                self.setPackList(pickListId: 4)
                
                self.checkWarehouseList(mainViewDataModel: mainViewDataModel)
            }
    }
    func getAddressByCoordinate(lat: Double, lng: Double, dialogsDataModel: DialogsDataModel) {
        UrlUtils.getRequest(url: UrlConstants.THIRD_PARTY_GET_ADDRESS_BY_COORDINATE+"?lat=\(lat)&lng=\(lng)", type: GeocodingAddressDto.self, dialogsDataModel: dialogsDataModel)
            .then{
                response in
                DispatchQueue.main.async {
                    self.goodPlace = (response?.prefecture ?? "")+(response?.city ?? "")
                }
            }
    }
    func needConfirm(){
        self.showNeedConfirm = true
    }
    
    func checkWarehouseList(mainViewDataModel: MainViewDataModel) -> Bool {
        // if warehouse does not exist
        if self.adressPickList.count == 0 {
            if groupKey != mainViewDataModel.loggedInUserGroup?.id {
                self.showAskGroupOwnerToRegisterWarehouseDialog = true
            } else {
                self.showPleaseRegisterWarehouseDialog = true
            }
            return false
        } else {
            return true
        }
    }
}
