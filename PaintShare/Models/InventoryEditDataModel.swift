//
//  InventoryEditDataModel.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/05/10.
//

import SwiftUI

class InventoryEditDataModel: ObservableObject {
    
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
    
    @Published var chargedOptionValue: String = ""
    
    @Published var navigationTag: Int? = nil
    
    var id: Int = -1
    
    @Published var useCategorykey: Int = -1 {
        didSet {
            useCategoryIdMessage = ""
        }
    }
    
    var useCategorykeyDefault: Int = -1
    
    @Published var useCategoryValue: String = ""
    
    @Published var adresskey: Int = -1 {
        didSet {
            adressIdMessage = ""
        }
    }
    
    @Published var adressValue: String = ""
    
    var adresskeyDefault: Int = -1
    
    @Published var adressIdMessage: String = ""
    
    @Published var makerkey: Int = -1 {
        didSet {
            makerIdMessage = ""
        }
    }
    
    var makerkeyDefault: Int = -1
    
    @Published var makerValue: String = ""
    
    @Published var goodsNameKey: Int = -1 {
        didSet {
            goodsNameIdMessage = ""
        }
    }
    
    @Published var goodsNameValue: String = ""
    
    @Published var standardId: Int = 0
    
    @Published var standardName: String = ""
    
    @Published var colorNumberId: Int = 0
    
    @Published var colorNumber: String = "#FFFFFF"
    
    @Published var colorCode: String = ""
    
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
        }
    }
    
    @Published var sellPublic: Bool = false {
        didSet {
            
        }
    }
    
    @Published var inventoryNumber: String = ""
    
    var materialImgKey: String? = nil
    
    var updatedAt: UInt64 = 0
    
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
        
    // validation messages
    @Published var ownedByIdMessage: String = ""
    
    @Published var makerIdMessage: String = ""
    
    @Published var useCategoryIdMessage: String = ""
    
    @Published var goodsNameIdMessage: String = ""
    
    @Published var amountMessage: String = ""
    
    @Published var lotNumberMessage: String = ""
    
    @Published var goodsPublicMessage: String = ""
    
    @Published var showEditConfirmDialog: Bool = false
    
    @Published var approveStatus: String = "0"
    
    @Published var weightMessage: String = ""

    @Published var priceMessage: String = ""
    
    @Published var specificationMessage: String = ""
    
    @Published var otherColorName: String = ""
    
    @Published var colorFlag: Bool = false
    
    func reset(){
        id = -1
        useCategorykey = -1
        useCategoryValue = ""
        makerkey = -1
        makerValue = ""
        goodsNameKey = -1
        goodsNameValue = ""
        standardId = 0
        standardName = ""
        colorNumberId = -1
        otherColorName = ""
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
        groupKey = -1
        groupValue = ""
        navigationTag = nil
        showEditConfirmDialog = false
        weightValue = ""
        priceValue = ""
        specification = ""
        goodPlace = ""
        goodPlaceCodeArray = []
        colorFlag = false
    }
    
    func saveAndUploadImage(dialogsDataModel: DialogsDataModel, inventorySearchDataModel: InventorySearchDataModel, inventoryInquiryDataModel: InventoryInquiryDataModel) {
        if self.logo != Constants.imageHolderUIImage! {
            let imageData = self.logo!.jpegData(compressionQuality: 0.6)!
            let request = MultipartFormDataRequest(url: URL(string: UrlConstants.FILE_UPLOAD_IMAGE)!)
            request.addDataField(named: "file", data: imageData, mimeType: "image/jpeg")
            
            UrlUtils.imgUploadRequest(request: request, dialogsDataModel: dialogsDataModel)
                .then {
                    dataString in
                    DispatchQueue.main.async {
                        self.save(imgKey: dataString, dialogsDataModel: dialogsDataModel, inventorySearchDataModel: inventorySearchDataModel, inventoryInquiryDataModel: inventoryInquiryDataModel)
                    }
                }
        } else {
            self.save(imgKey: nil, dialogsDataModel: dialogsDataModel, inventorySearchDataModel: inventorySearchDataModel, inventoryInquiryDataModel: inventoryInquiryDataModel)
        }
    }
    
    func save(imgKey: String?, dialogsDataModel: DialogsDataModel, inventorySearchDataModel: InventorySearchDataModel, inventoryInquiryDataModel: InventoryInquiryDataModel){
        let body = InventoryBody(id: id, ownedById: groupKey == -1 ? nil : groupKey , makerId: makerkey == -1 ? nil : makerkey, useCategoryId: useCategorykey == -1 ? nil : useCategorykey, goodsNameId: goodsNameKey == -1 ? nil : goodsNameKey, standardId: standardId, colorNumberId: colorFlag ? -1 : colorNumberId, otherColorName: colorFlag ? otherColorName : "", isColor: true, materialImgKey: imgKey, amount: Double(amount)!, expireDate: expireDateStr, lotNumber: lotNumber, goodsPublic: inventoryPublic ? 1 : 0, goodsNameName: goodsNameValue, price: priceValue.filter{$0 != ","}, weight: weightValue, specification: specification, goodsPlace: goodPlaceCodeArray.count == 0 ? goodPlace : nil, goodsPlaceCodes: goodPlaceCodeArray, approveStatus: approveStatus, saleFlag: sellPublic ? 1 : 0, warehouseId: adresskey == -1 ? nil : adresskey)
        UrlUtils.postRequest(url: UrlConstants.PAINT_SAVE_CHANGE, body: body, dialogsDataModel: dialogsDataModel)
            .then {
                inventorySearchDataModel.navigationTag = nil
                inventoryInquiryDataModel.navigationTag = nil
                inventorySearchDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
                DispatchQueue.main.async {
                    self.navigationTag = 2
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
                    if let specificationError = validationError.errors["specification"] {
                        self.specificationMessage = specificationError
                    }
                }
            }
    }
    
    func initData(id: Int, dialogsDataModel: DialogsDataModel){
        self.id = id;
        // メーカーマスタ 取得
        UrlUtils.getRequest(url: UrlConstants.PAINT + "/\(id)", type: InventoryDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                result in
                self.makerValue = (result?.maker.name)!
                self.makerkey = (result?.maker.id)!
                self.useCategoryValue = result?.useCategory?.name ?? ""
                self.useCategorykey = result?.useCategory == nil ? -1 : (result?.useCategory?.id)!
                self.goodsNameValue  = (result?.goodsNameName)!
                self.goodsNameKey  = result?.goodsName == nil ? -1 : (result?.goodsName?.id)!
                
                if ((result?.colorNumber) != nil) {
                    self.colorNumberId = result?.colorNumber?.id ?? -1
                    self.colorNumber = result?.colorNumber?.colorNumber ?? ""
                    self.standardName = result?.colorNumber?.maker.name ?? ""
                    self.colorCode = result?.colorNumber?.colorCode ?? ""
                    self.colorFlag = false
                    self.otherColorName=""
                }
                else
                {
                    self.colorFlag = true
                    self.otherColorName = result?.otherColorName ?? ""
                    self.colorNumberId = -1
                    self.standardName = ""
                    self.colorCode = ""
                    self.colorNumber = ""
                }
                
                self.standardId = (result?.standard.id)!
                self.amount = String((result?.amount)!)
                self.expireDateStr = (result?.expireDate)!
                self.materialImgKey = result?.materialImgKey
                self.updatedAt = (result?.updatedAt)!
                self.lotNumber = (result?.lotNumber)!
                self.inventoryNumber = (result?.inventoryNumber)!
                self.inventoryPublic = result?.goodsPublic == 0 ? false : true
                self.loadImg(dialogsDataModel: dialogsDataModel)
                self.groupKey = (result?.ownedBy.id)!
                self.groupValue = (result?.ownedBy.groupName)!
                self.adresskey = (result?.warehouse.id)!
                self.adressValue = (result?.warehouse.name)!
                self.priceValue = result?.price == nil ? "" : String((result?.price) ?? 0)
                self.weightValue = String((result?.weight) ?? 0)
                self.specification = result?.specification  ?? ""
                self.sellPublic = result?.saleFlag == 1 ? true : false
                self.selectedSell = result?.saleFlag == 1 ? 2 : 0
                self.getAdress(groupId: self.groupKey, dialogsDataModel: dialogsDataModel)
                self.goodPlace = result?.goodsPlace ?? ""
                self.goodPlaceCodeArray = result?.goodsPlaceCodes ?? []
            }
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
                    }
                    let pick = PickItem(key: groupitem.id,value: groupitem.groupName)
                    self.groupPickList.append(pick)
                }
            }
    }
    
    func loadImg(dialogsDataModel: DialogsDataModel) {
        if (self.materialImgKey == nil) {
            return
        }
        UrlUtils.getData(urlString: UrlConstants.IMAGE_S3_ROOT + self.materialImgKey!) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            DispatchQueue.main.async {
                self.logo = UIImage(data: data)
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
    
    func setPickValue(pickId: Int, dialogsDataModel: DialogsDataModel){
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
            self .getAdress(groupId: self.groupKey, dialogsDataModel: dialogsDataModel)
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
    
    func getAdress(groupId: Int, dialogsDataModel: DialogsDataModel){
        // 倉庫
        UrlUtils.getRequest(url: UrlConstants.WAREHOUSE_SEARCH_WAREHOUSEDTO+"/\(groupId)", type: [WarehouseDto].self, dialogsDataModel: dialogsDataModel)
            .then {
                warehouseDtoList in
                self.adressPickList = []
                for warehouseitem in warehouseDtoList! {
                    if self.adresskeyDefault == -1 {
                        self.adresskeyDefault = warehouseitem.id
                    }
                    let pick = PickItem(key: warehouseitem.id,value: warehouseitem.name)
                    self.adressPickList.append(pick)
                }
                self.setPackList(pickListId: 4)
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
}
