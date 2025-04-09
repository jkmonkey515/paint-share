//
//  ManagerViewDataModel.swift
//  PaintShare
//
//  Created by Lee on 2022/12/23.
//

import SwiftUI

class ManagerViewDataModel: ObservableObject {
    
    @Published var bankName: String = ""{
        didSet {
            bankNameMessage = ""
        }
    }
    
    @Published var bankCode: String = ""{
        didSet {
            bankCodeMessage = ""
        }
    }
    
    @Published var branchName: String = ""{
        didSet {
            branchNameMessage = ""
        }
    }
    
    @Published var branchCode: String = ""{
        didSet {
            branchCodeMessage = ""
        }
    }
    
    @Published var depositType: String = ""{
        didSet {
            depositTypeCodeMessage = ""
        }
    }
    
    @Published var accountNo: String = ""{
        didSet {
            accountNoMessage = ""
        }
    }
    
    @Published var accountName: String = ""{
        didSet {
            accountNameMessage = ""
        }
    }
    
    @Published var showSavedManagerInfoDialog: Bool = false
    
    @Published var showSavedDialog: Bool = false
    
    @Published var fromOrderListView: Bool = false
    
    @Published var depositTypeKey: Int = -1
    
    @Published var depositTypeDefault: Int = -1
    
    @Published var depositTypeList: [PickItem] = []
    
    @Published var showDepositTypePick : Bool = false
    
    @Published var addBottom: Bool = false
    
    // validation messages
    @Published var bankNameMessage: String = ""
    @Published var bankCodeMessage: String = ""
    @Published var branchNameMessage: String = ""
    @Published var branchCodeMessage: String = ""
    @Published var depositTypeCodeMessage: String = ""
    @Published var accountNoMessage: String = ""
    @Published var accountNameMessage: String = ""
    
    var mstdepositTypeList:[MstDepositType]=[]
    
//    init(){
//     //   depositTypeList.append(PickItem(key: -1, value: ""))
//        depositTypeList.append(PickItem(key: 0, value: "普通預金"))
//        depositTypeList.append(PickItem(key: 1, value: "当座預金"))
//        depositTypeList.append(PickItem(key: 2, value: "貯蓄預金"))
//        depositTypeList.append(PickItem(key: 3, value: "その他"))
//    }
    
    func reset(){
        bankName = ""
        bankCode = ""
        branchName = ""
        branchCode = ""
        depositType = ""
        accountNo = ""
        accountName = ""
        showSavedManagerInfoDialog = false
        showSavedDialog = false
        fromOrderListView = false
        bankNameMessage = ""
        bankCodeMessage = ""
        branchNameMessage = ""
        branchCodeMessage = ""
        depositTypeCodeMessage = ""
        accountNoMessage = ""
        accountNameMessage = ""
    }
 
//    func setDepositTypeValue(){
//        let depositTypeList=depositTypeList.first(where: {$0.key == depositTypeKey})
//        depositType = depositTypeList?.value ?? ""
//    }
//
//    func findDepositTypeKey(value:String){
//        let depositTypeList = depositTypeList.first(where: {$0.value == value})
//                depositTypeKey = depositTypeList?.key ?? 0
//    }
//
    
    func setPickValue(pickId: Int){
        depositTypeKey = pickId == -1 ? depositTypeDefault : pickId
        depositType = getValueById(pickId: depositTypeKey,list: depositTypeList)
    }
    
    func getValueById(pickId: Int, list:[PickItem]) -> String{
        for item in list {
            if item.key == pickId{
                return item.value
            }
        }
        return ""
    }
    
    func getDepositTypeCodeByName(value:String) -> String{
        for item in self.mstdepositTypeList {
            if item.name == value{
                return item.code
            }
        }
        return ""
    }
    
    func getKeyByCode(code:String) ->Int{
        for item in self.mstdepositTypeList{
            if item.code == code{
                for pickItem in self.depositTypeList{
                    if item.name == pickItem.value{
                        return pickItem.key
                    }
                }
            }
        }
        return -1
    }
    
    func setManagerInfo(dialogsDataModel: DialogsDataModel){
        //預金種類
        UrlUtils.getRequest(url: UrlConstants.MST_DEPOSIT_TYPES, type: [MstDepositType].self, dialogsDataModel: dialogsDataModel)
            .then {
                mstDepositTypes in
                self.depositTypeList = []
                self.mstdepositTypeList = mstDepositTypes ?? []
                for depositTypeItem in mstDepositTypes! {
                    if self.depositTypeDefault == -1 {
                        self.depositTypeDefault = depositTypeItem.id
                    }
                    let pick = PickItem(key: depositTypeItem.id,value:depositTypeItem.name)
                    self.depositTypeList.append(pick)
                }
                
                UrlUtils.getRequest(url: UrlConstants.TRANSFER_ACCOUNT, type: TransferAccountDto.self, dialogsDataModel: dialogsDataModel)
                    .then{
                        transferAccountDto in
                        DispatchQueue.main.async {
                            self.bankName = transferAccountDto?.bankName ?? ""
                            self.bankCode = transferAccountDto?.bankCode ?? ""
                            self.branchName = transferAccountDto?.branchName ?? ""
                            self.branchCode = transferAccountDto?.branchCode ?? ""
                            self.accountNo = transferAccountDto?.accountNo ?? ""
                            self.accountName = transferAccountDto?.accountName ?? ""
                            
                            if transferAccountDto?.depositTypeCode != nil{
                                self.setPickValue(pickId: self.getKeyByCode(code: transferAccountDto?.depositTypeCode ?? ""))
                            }else{
                                self.depositTypeKey = -1
                            }
                        }
                    }
            }
        

    }
    
    func validManagerInfo(dialogsDataModel: DialogsDataModel){
        let body = TransferAccountBody(bankName: bankName,bankCode: bankCode, branchName: branchName,branchCode: branchCode, depositTypeCode: self.getDepositTypeCodeByName(value:self.depositType), accountNo: accountNo, accountName: accountName)
        UrlUtils.postRequest(url: UrlConstants.TRANSFER_ACCOUNT_IS_VALID, body: body, dialogsDataModel: dialogsDataModel)
            .then{
                self.showSavedManagerInfoDialog = true
            }.catch{
                error in
                if let validationError = error as? ValidationError {
                    if let bankNameError = validationError.errors["bankName"] {
                        self.bankNameMessage = bankNameError
                    }
                    if let bankCodeError = validationError.errors["bankCode"] {
                        self.bankCodeMessage = bankCodeError
                    }
                    if let branchNameError = validationError.errors["branchName"] {
                        self.branchNameMessage = branchNameError
                    }
                    if let branchCodeError = validationError.errors["branchCode"] {
                        self.branchCodeMessage = branchCodeError
                    }
                    if let depositTypeCodeError = validationError.errors["depositTypeCode"] {
                        self.depositTypeCodeMessage = depositTypeCodeError
                    }
                    if let accountNoError = validationError.errors["accountNo"] {
                        self.accountNoMessage = accountNoError
                    }
                    if let accountNameError = validationError.errors["accountName"] {
                        self.accountNameMessage = accountNameError
                    }
                }
            }
        }
    
    func saveManagerInfo(dialogsDataModel: DialogsDataModel){
        let body = TransferAccountBody(bankName: bankName,bankCode: bankCode, branchName: branchName,branchCode: branchCode,depositTypeCode: self.getDepositTypeCodeByName(value: self.depositType), accountNo: accountNo, accountName: accountName)
        UrlUtils.postRequest(url: UrlConstants.TRANSFER_ACCOUNT, body: body, dialogsDataModel: dialogsDataModel)
            .then{
               // self.showSavedManagerInfoDialog = false
                //self.showSavedManagerInfoDialog = true
                self.showSavedDialog = true
              //  dialogsDataModel.mainViewNavigationTag = nil
            }.catch{
                error in
                if let validationError = error as? ValidationError {
                    if let bankNameError = validationError.errors["bankName"] {
                        self.bankNameMessage = bankNameError
                    }
                    if let bankCodeError = validationError.errors["bankCode"] {
                        self.bankCodeMessage = bankCodeError
                    }
                    if let branchNameError = validationError.errors["branchName"] {
                        self.branchNameMessage = branchNameError
                    }
                    if let branchCodeError = validationError.errors["branchCode"] {
                        self.branchCodeMessage = branchCodeError
                    }
                    if let depositTypeCodeError = validationError.errors["depositTypeCode"] {
                        self.depositTypeCodeMessage = depositTypeCodeError
                    }
                    if let accountNoError = validationError.errors["accountNo"] {
                        self.accountNoMessage = accountNoError
                    }
                    if let accountNameError = validationError.errors["accountName"] {
                        self.accountNameMessage = accountNameError
                    }
                }
            }
        }
}
