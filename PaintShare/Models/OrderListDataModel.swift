//
//  OrderListDataModel.swift
//  PaintShare
//
//  Created by Lee on 2022/6/30.
//

import SwiftUI

class OrderListDataModel: ObservableObject {

    @Published var navigationTag: Int? = nil
    
    @Published var orderListItems: [OrderListItem] = []
    
    @Published var showTransferAccountRegistrationDialog: Bool = false
    
    @Published var transferAccountDto:TransferAccountDto? = nil
    
    @Published var showRegistrationDialogTag:Int=0
        
    func getListData(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.ORDER_GET_GROUP_OWNER_ORDERS + "?paymentStatus=1", type: [OrderListItem].self, dialogsDataModel: dialogsDataModel)
            .then {
                result in
                self.orderListItems = []
//                if (result != nil){
                    for Item in result! {
                        self.orderListItems.append(Item)
                    }
                    if !result!.isEmpty{
                        self.getTransferAccountDto(dialogsDataModel: dialogsDataModel)
                    }
//                }
                
            }
    }
    
    func getTransferAccountDto(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.TRANSFER_ACCOUNT, type: TransferAccountDto.self, dialogsDataModel: dialogsDataModel)
            .then{
                transferAccountDto in
                self.transferAccountDto = transferAccountDto
                
                if transferAccountDto!.bankName == nil{
//                        if(self.showRegistrationDialogTag == 0){
                            self.showTransferAccountRegistrationDialog = true
//                            self.showRegistrationDialogTag = 1
//                    }
                }
            }
    }
    
}
