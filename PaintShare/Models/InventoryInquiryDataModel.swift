//
//  InventoryInquiryDataModel.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/05/10.
//

import SwiftUI

class InventoryInquiryDataModel: ObservableObject {
    
    @Published var ownerId: Int = -1 //
    
    @Published var groupId: Int = -1 //
    
    @Published var navigationTag: Int? = nil
    
    @Published var editPromise: Bool = false
    
    @Published var userId: Int = -1
    
    @Published var isRelated: Bool = true
    
    @Published var shareGroup: GroupDto?
    
    var id: Int = -1
    
    //group:1、sell:2
    @Published var identityType: Int = 0
    
    @Published var adressValue: String = ""
    
    @Published var priceValue: String = ""
    
    @Published var weightValue: String = ""
    
    @Published var specification: String = ""
    
    @Published var makerValue: String = ""
    
    @Published var useCategoryValue: String = ""
    
    @Published var goodsNameValue: String = ""
    
    @Published var colorNumber: String = "#FFFFFF"
    
    @Published var colorCode: String = ""
    
    @Published var colorMakerName: String = ""
    
    @Published var otherColorName: String = ""
    
    @Published var colorFlag: Bool = false
    
    @Published var maxInt: Int = 0
    
    @Published var maxFloat: Int = 0
    
    @Published var amount: String = "0.0"{
        didSet{
            let  strarray = amount.components(separatedBy: ".")
            maxInt = Int(strarray.first ?? "0") ?? 0
            maxFloat = Int(strarray.last ?? "0") ?? 0
        }
    }
    
    @Published var amountInteger: Int = 0
    
    @Published var amountDecimal: Int = 0
    
    @Published var expireDateStr: String = ""
    
    @Published var inventoryNumber: String = ""
    
    @Published var inventoryPublic: Bool = false
    
    @Published var inventorySaleNumber: String = ""
    
    @Published var inventorySale: Bool = false
    
    @Published var inventoryPublicStr: String = ""
    
    @Published var groupValue: String = ""
    
    @Published var likeCount: Int = 0
    
    @Published var lotNumber: String = ""
    
    @Published var wishNumber: String = "1.0"
    
    @Published var wishNumberInteger: Int = 1
    
    @Published var wishNumberDecimal: Int = 0
    
    var materialImgKey: String? = nil
    
    var updatedAt: UInt64 = 0
    
    @Published var showAmountModal: Bool = false
    
    @Published var showAmountPicker: Bool = false
    
    @Published var showWishModal: Bool = false
    
    @Published var showWishPicker: Bool = false
    
    @Published var showDeletePaintDialog: Bool = false
    
  //  @Published var deletedFromSearch: Int = -1
    
    @Published var showPaintDeletedDialog: Bool = false
    
    @Published var showPaintFavoriteDeletedDialog: Bool = false
    
    func reset(){
        ownerId = -1 //
        groupId = -1 //
        id = -1
        makerValue = ""
        useCategoryValue = ""
        goodsNameValue = ""
        colorNumber = "#FFFFFF"
        colorCode = ""
        amount = "0.0"
        amountInteger = 0
        amountDecimal = 0
        likeCount = 0
        expireDateStr = ""
        inventoryNumber = ""
        inventoryPublic = false
        inventoryPublicStr = ""
        materialImgKey = nil
        updatedAt = 0
        showAmountModal = false
        showAmountPicker = false
        navigationTag = nil
        editPromise = false
        lotNumber = ""
        weightValue = ""
        specification = ""
        wishNumber = "1.0"
        wishNumberInteger = 1
        wishNumberDecimal = 0
        showDeletePaintDialog = false
     //   deletedFromSearch = -1
        showPaintDeletedDialog = false
        showPaintFavoriteDeletedDialog = false
        colorFlag = false
        otherColorName = ""
    }
    
    func initData(id: Int, dialogsDataModel: DialogsDataModel){
        self.id = id;
        // 在庫データ 取得
        UrlUtils.getRequest(url: UrlConstants.PAINT + "/\(id)", type: InventoryDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                result in
                self.ownerId = (result?.ownedBy.groupOwner.id)! //
                self.groupId = (result?.ownedBy.id)!
                self.makerValue = (result?.maker.name)!
                self.useCategoryValue = result?.useCategory?.name ?? ""
                self.goodsNameValue  = (result?.goodsNameName)!
                if ((result?.colorNumber) != nil){
                    self.colorNumber = result?.colorNumber?.colorNumber ?? ""
                    self.colorCode = result?.colorNumber?.colorCode ?? ""
                    self.colorMakerName = result?.colorNumber?.maker.name ?? ""
                    self.colorFlag = false
                }
                else
                {
                    self.colorFlag = true
                    self.otherColorName = result?.otherColorName ?? ""
                }
                self.amount = String((result?.amount)!)
                self.expireDateStr = (result?.expireDate)!
                self.materialImgKey = result?.materialImgKey
                self.updatedAt = (result?.updatedAt)!
                self.inventoryNumber = (result?.inventoryNumber)!
                self.inventoryPublicStr = result?.goodsPublic == 0 ? "非公開" : "共有中"
                self.inventoryPublic = result?.goodsPublic == 0 ? false : true
                self.groupValue = (result?.ownedBy.groupName)!
                self.amountInteger = Int((result?.amount)!)
                self.amountDecimal = Int(self.amount.split(separator: ".")[1])!
                self.amountDecimal = self.amountDecimal == 5 ? 50 : self.amountDecimal
                self.identityType = result?.saleFlag == 0 ? 1 : 2
                self.likeCount = (result?.likeCount)!
                self.priceValue = "\(result?.price ?? 0)"
                self.adressValue = (result?.warehouse.name)!
                self.lotNumber = result?.lotNumber ?? ""
                self.weightValue = "\(result?.weight ?? 0)"
                self.specification = result?.specification ?? ""
             //   self.deletedFromSearch = result?.deletedFromSearch ?? -1
                self.judgeRelated(dialogsDataModel: dialogsDataModel)
            }
        
        // 在庫データ 編修権限取得
        UrlUtils.getRequest(url: UrlConstants.PAINT_EDIT_PROMISE + "/\(id)", type: InventoryEditPromiseDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                result in
                self.editPromise = (result?.promise)!
            }
    }
    
    func changeAmount(dialogsDataModel: DialogsDataModel,inventorySearchDataModel: InventorySearchDataModel){
        let newAmount = String(amountInteger) + "." + String(amountDecimal)
        if newAmount == amount {
            return
        }
        if id == -1 {
            return
        }
        
        let body = InventoryChangeAnountBody(id: id, amount: Double(newAmount)!)
        UrlUtils.postRequest(url: UrlConstants.PAINT_CHANGE_AMOUNT, body: body, dialogsDataModel: dialogsDataModel)
            .then {
                self.amount = newAmount
                inventorySearchDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
            }
    }
    
    func judgeRelated(dialogsDataModel: DialogsDataModel){
        UrlUtils.postRequest(url: UrlConstants.USER_GROUP_RELATION_ISRELATED + "?groupId=\(self.groupId)&userId=\(self.userId)", body: EmptyBody(), type: InventoryIsRelatedDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                result in
                self.isRelated = result!.related
                self.shareGroup = result?.groupDto
            }
    }
    
    func paintDelete(dialogsDataModel: DialogsDataModel, inventorySearchDataModel: InventorySearchDataModel, id: Int) {
        UrlUtils.postRequest(url: UrlConstants.PAINT_REMOVE_PAINT_FROM_SEATCH + "/\(id)", body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then {
                self.showDeletePaintDialog = false
                inventorySearchDataModel.initData(dialogsDataModel: dialogsDataModel)
                //DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    inventorySearchDataModel.navigationTag = nil
                //})
            }
    }
}
