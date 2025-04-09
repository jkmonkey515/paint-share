//
//  InventoryApprovalDataModel.swift
//  PaintShare
//
//  Created by Lee on 2022/6/21.
//

import SwiftUI

class InventoryApprovalDataModel:ObservableObject{
    
    @Published var navigationTag: Int? = nil
    
    @Published var resultCount: Int = 0
    
    @Published var showApprove: Bool = false
    
    @Published var showDelete: Bool = false
    
    @Published var approvalListItems: [ApprovalListItem] = []
    
    var userIdToApprove: Int?
    
    var userIdToDelete: Int?
    
    func getListData(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.PAINT_GET_OWNER_NOT_APPROVE_PAINT_LIST, type: [InventoryDto].self, dialogsDataModel: dialogsDataModel)
            .then {
                result in
                self.resultCount = result?.count ?? 0
                self.approvalListItems = []
                for inventoryItem in result! {
                    let approvalItem = ApprovalListItem(id: inventoryItem.id, groupName: inventoryItem.ownedBy.groupName, goodsNameName: inventoryItem.goodsNameName, price: inventoryItem.price ?? 0, materialImgKey: inventoryItem.materialImgKey, updatedAt: inventoryItem.updatedAt)
                    self.approvalListItems.append(approvalItem)
                }
            }
    }
    
    func approve(dialogsDataModel: DialogsDataModel) {
        if (self.userIdToApprove == nil) {
            return
        }
        UrlUtils.postRequest(url: UrlConstants.PAINT_APPROVE + "/\(self.userIdToApprove!)", body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then {
                self.getListData(dialogsDataModel: dialogsDataModel)
            }
            .always {
                self.userIdToApprove = nil
            }
    }
    
    func delete(dialogsDataModel: DialogsDataModel) {
        if (self.userIdToDelete == nil) {
            return
        }
        UrlUtils.postRequest(url: UrlConstants.PAINT_DELETE + "/\(self.userIdToDelete!)", body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then {
                self.getListData(dialogsDataModel: dialogsDataModel)
            }
            .always {
                self.userIdToDelete = nil
            }
    }
}
